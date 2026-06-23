// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCNetwork",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "LBCNetwork", targets: ["LBCNetwork"]),
    ],
    targets: [
        .target(
            name: "LBCNetwork",
            path: "LBCNetwork",
            exclude: ["Info.plist", "LBCNetwork.h"]
        ),
    ]
)
