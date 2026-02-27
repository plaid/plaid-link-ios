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
        ),
        .library(
            name: "LinkKitObjC",
            targets: ["LinkKitObjC"]
        )
    ],
    targets: [
        .target(
            name: "LinkKitObjC",
            dependencies: [
                "LinkKitObjCInternal",
                "LinkKit"
            ],
            path: "Sources/ObjC-Support/Swift"
        ),
        .target(
            name: "LinkKitObjCInternal",
            dependencies: [
                "LinkKit"
            ],
            path: "Sources/ObjC-Support/ObjectiveC",
            publicHeadersPath: "include"
        ),
        .binaryTarget(
            name: "LinkKit",
            path: "LinkKit.xcframework"
        ),
        .testTarget(
            name: "LinkKitObjCTests",
            dependencies: [
                "LinkKitObjC"
            ]
        ),
    ]
)
