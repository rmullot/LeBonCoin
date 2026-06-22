# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

iOS app (Swift 5, deployment target iOS 11.0) displaying a list of classified ads (the leboncoin "paperclip" sample API). UI is UIKit-only, built programmatically — no storyboards for the feature screens. There is no dependency manager: everything is plain Xcode subprojects/dynamic frameworks wired together in a single workspace (no CocoaPods/Carthage/SPM).

## Build & Test

Always operate through the **workspace**, not the individual `.xcodeproj`s. App scheme is `test_Romain_MULLOT`.

```bash
# Build the app
xcodebuild -workspace LeBonCoin.xcworkspace -scheme test_Romain_MULLOT \
  -destination 'platform=iOS Simulator,name=iPhone 15' build

# Run all tests (unit + UI)
xcodebuild -workspace LeBonCoin.xcworkspace -scheme test_Romain_MULLOT \
  -destination 'platform=iOS Simulator,name=iPhone 15' test

# Run a single test class or method
xcodebuild -workspace LeBonCoin.xcworkspace -scheme test_Romain_MULLOT \
  -destination 'platform=iOS Simulator,name=iPhone 15' test \
  -only-testing:test_Romain_MULLOTTests/AdvertisementsViewModelTest

# Framework-only tests (LBCCore has its own scheme/test target)
xcodebuild -workspace LeBonCoin.xcworkspace -scheme LBCCore \
  -destination 'platform=iOS Simulator,name=iPhone 15' test
```

Adjust the simulator `name` to one available locally (`xcrun simctl list devices`).

## Architecture

The codebase is **MVVM-C** (Model–View–ViewModel + Coordinator) on top of a **layered framework stack**. Understanding the layering matters because each layer is a separate framework target with a strict dependency direction — adding a cross-layer import the wrong way will break the build.

### Framework layers (low → high)

```
LBCNetwork   (no LBC deps)   reachability, URLSession activity indicator, MultiCastDelegate
LBCCore      (no LBC deps)   formatters, Swift extensions, InjectionMapService (IoC container)
LBCAPI       → Core,Network  remote API client, JSON DTOs, ParserService
LBCCoreData  → API,Core      Core Data stack + NSManagedObject subclasses, persistence
LBCBridge    → API,CoreData  domain models + Service facades (the public API the app consumes)
LBCUIKit     → Core,Network   reusable UIKit components (LBCScrollView, image cache, view extensions)
test_…MULLOT → Bridge,API,CoreData   the app: screens, ViewModels, Coordinators
```

The app target talks almost exclusively to **LBCBridge** — that is the intended public surface. `LBCBridge` owns the plain Swift domain models (`Advertisement`, `Category`) and the two service facades.

### Data flow

`AdvertisementService` / `CategoryService` (in LBCBridge) are the orchestrators:

1. `refresh…` → `APIService` (LBCAPI) fetches JSON from `https://raw.githubusercontent.com/leboncoin/paperclip/master/`, parses via `ParserService`.
2. Results are written into Core Data via `CoreDataService` (LBCCoreData) — old rows cleared, new ones saved.
3. The UI never reads the network directly. `getAdvertisementsWithFilter` / `getCategories` read back **from Core Data** (applying `NSPredicate` filters / sort), map the managed objects to domain models, and return those. **Core Data is the source of truth for the UI.**

Offline handling: `APIService.onlineMode` (driven by `ReachabilityService`) short-circuits network calls; the services then serve whatever is already cached in Core Data.

### App layer (test_Romain_MULLOT)

- **Coordinators** own navigation. `AppDelegate` creates `ApplicationCoordinator`, which builds the root `UINavigationController` and pushes the ad list. Child coordinators (`FilterCoordinator`, `AdvertisementDescriptionCoordinator`) are added/removed via the `Coordinator` protocol's `childCoordinators` array; ViewModels notify coordinators through delegate protocols (e.g. `AdvertisementsViewModelDelegate`).
- **ViewModels** are protocol-fronted (`…ViewModelProtocol`) and take their services via initializer injection, which is what makes them unit-testable — see the `*Mock` classes in `test_Romain_MULLOTTests`.
- Feature folders: `AdvertisementsList/`, `Filter/`, `AdvertisementDescription/`.

## Conventions & gotchas

- **Dependency injection is manual via initializer injection + `.sharedInstance` singletons.** `AdvertisementService`, `CategoryService`, `APIService`, `CoreDataService`, etc. are all singletons; ViewModels receive them through their `init`. Tests substitute `*Mock` conforming to the service protocol.
- `LBCCore/InjectionMapService` is a generic IoC container that exists in the codebase but is **not currently wired into the app** — nothing calls `register`/`resolve`. Don't assume DI goes through it.
- When adding behavior, respect the layer direction above: domain/service logic belongs in **LBCBridge**, persistence in **LBCCoreData**, networking/DTOs in **LBCAPI**. The app target should reach for LBCBridge types, not LBCAPI/LBCCoreData internals, where possible.
- Service methods return `Result<…, Error>` via completion handlers (no Combine/async-await).
- Each framework has a `+ModuleName.swift` extension-file naming convention (e.g. `String+LBCCore.swift`, `APIService+Advertisements.swift`) for grouping by concern.
