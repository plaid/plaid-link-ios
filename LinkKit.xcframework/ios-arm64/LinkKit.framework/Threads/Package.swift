// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Threads",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Threads",
            targets: ["Threads"]

        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Threads",
            dependencies: [],
            resources: [
                .process("Icons.xcassets")
            ]
        ),
        .testTarget(
            name: "ThreadsTests",
            dependencies: ["Threads"]
        ),
    ]
)
