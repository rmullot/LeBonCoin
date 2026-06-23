// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCCore",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "LBCCore", targets: ["LBCCore"]),
    ],
    targets: [
        .target(
            name: "LBCCore",
            path: "LBCCore",
            exclude: ["Info.plist", "LBCCore.h"]
        ),
    ]
)
