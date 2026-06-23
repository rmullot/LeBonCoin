// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCBridge",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "LBCBridge", targets: ["LBCBridge"]),
    ],
    dependencies: [
        .package(path: "../LBCAPI"),
        .package(path: "../LBCCoreData"),
    ],
    targets: [
        .target(
            name: "LBCBridge",
            dependencies: [
                .product(name: "LBCAPI", package: "LBCAPI"),
                .product(name: "LBCCoreData", package: "LBCCoreData"),
            ],
            path: "LBCBridge",
            exclude: ["Info.plist", "LBCBridge.h"]
        ),
    ]
)
