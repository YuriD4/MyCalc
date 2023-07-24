// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCSettings",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MCSettings",
            targets: ["MCSettings"]),
    ],
    targets: [
        .target(
            name: "MCSettings",
            dependencies: []),
        .testTarget(
            name: "MCSettingsTests",
            dependencies: ["MCSettings"]),
    ]
)

