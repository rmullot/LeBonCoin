// swift-tools-version:5.7
import PackageDescription

// Local Swift Package that re-exposes the LeBonCoin framework layers as SPM
// products. The source files stay where they are (each target points at the
// existing `<Module>/<Module>` folder via `path:`), so this package lives
// alongside the original .xcodeproj framework targets without moving anything.
//
// Dependency direction (low -> high):
//   LBCNetwork, LBCCore           (no internal deps)
//   LBCAPI      -> Core, Network
//   LBCCoreData -> API, Core
//   LBCBridge   -> API, CoreData
//   LBCUIKit    -> Core, Network
let package = Package(
    name: "LBCFrameworks",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "LBCNetwork", targets: ["LBCNetwork"]),
        .library(name: "LBCCore", targets: ["LBCCore"]),
        .library(name: "LBCAPI", targets: ["LBCAPI"]),
        .library(name: "LBCCoreData", targets: ["LBCCoreData"]),
        .library(name: "LBCBridge", targets: ["LBCBridge"]),
        .library(name: "LBCUIKit", targets: ["LBCUIKit"]),
    ],
    targets: [
        .target(
            name: "LBCNetwork",
            path: "LBCNetwork/LBCNetwork",
            exclude: ["Info.plist", "LBCNetwork.h"]
        ),
        .target(
            name: "LBCCore",
            path: "LBCCore/LBCCore",
            exclude: ["Info.plist", "LBCCore.h"]
        ),
        .target(
            name: "LBCAPI",
            dependencies: ["LBCCore", "LBCNetwork"],
            path: "LBCAPI/LBCAPI",
            exclude: ["Info.plist", "LBCAPI.h"]
        ),
        .target(
            name: "LBCCoreData",
            dependencies: ["LBCAPI", "LBCCore"],
            path: "LBCCoreData/LBCCoreData",
            exclude: ["Info.plist", "LBCCoreData.h"],
            resources: [
                .process("LBCCoreData.xcdatamodeld")
            ]
        ),
        .target(
            name: "LBCBridge",
            dependencies: ["LBCAPI", "LBCCoreData"],
            path: "LBCBridge/LBCBridge",
            exclude: ["Info.plist", "LBCBridge.h"]
        ),
        .target(
            name: "LBCUIKit",
            dependencies: ["LBCCore", "LBCNetwork"],
            path: "LBCUIKit/LBCUIKit",
            exclude: ["Info.plist", "LBCUIKit.h"]
        ),
    ]
)
