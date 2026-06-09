// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "LinkKit",
    platforms: [
        .iOS(.v15),
        .macCatalyst(.v15),
    ],
    products: [
        .library(
            name: "LinkKit",
            targets: ["LinkKit"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "LinkKit",
            path: "LinkKit.xcframework"
        )
    ]
)
