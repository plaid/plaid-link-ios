// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "LinkKit",
  platforms: [
    .iOS(.v14),
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
