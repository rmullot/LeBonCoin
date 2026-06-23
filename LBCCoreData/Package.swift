// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCCoreData",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "LBCCoreData", targets: ["LBCCoreData"]),
    ],
    dependencies: [
        .package(path: "../LBCAPI"),
        .package(path: "../LBCCore"),
    ],
    targets: [
        .target(
            name: "LBCCoreData",
            dependencies: [
                .product(name: "LBCAPI", package: "LBCAPI"),
                .product(name: "LBCCore", package: "LBCCore"),
            ],
            path: "LBCCoreData",
            exclude: ["Info.plist", "LBCCoreData.h"],
            resources: [
                .process("LBCCoreData.xcdatamodeld")
            ]
        ),
    ]
)
