// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCUIKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "LBCUIKit", targets: ["LBCUIKit"]),
    ],
    dependencies: [
        .package(path: "../LBCCore"),
        .package(path: "../LBCNetwork"),
    ],
    targets: [
        .target(
            name: "LBCUIKit",
            dependencies: [
                .product(name: "LBCCore", package: "LBCCore"),
                .product(name: "LBCNetwork", package: "LBCNetwork"),
            ],
            path: "LBCUIKit",
            exclude: ["Info.plist", "LBCUIKit.h"]
        ),
    ]
)
