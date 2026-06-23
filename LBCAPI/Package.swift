// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "LBCAPI",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "LBCAPI", targets: ["LBCAPI"]),
    ],
    dependencies: [
        .package(path: "../LBCCore"),
        .package(path: "../LBCNetwork"),
    ],
    targets: [
        .target(
            name: "LBCAPI",
            dependencies: [
                .product(name: "LBCCore", package: "LBCCore"),
                .product(name: "LBCNetwork", package: "LBCNetwork"),
            ],
            path: "LBCAPI",
            exclude: ["Info.plist", "LBCAPI.h"]
        ),
    ]
)
