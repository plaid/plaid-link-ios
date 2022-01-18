// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "LinkKit",
  platforms: [
    .iOS(.v11),
  ],
  products: [
    .library(
      name: "LinkKit",
      targets: ["LinkKit"]
    ),
  ],
  targets: [
    .binaryTarget(
      name: "LinkKit",
      path: "LinkKit.xcframework"
    ),
  ]
)
