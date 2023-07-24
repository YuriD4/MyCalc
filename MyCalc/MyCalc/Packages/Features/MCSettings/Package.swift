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
    dependencies: [
        .package(path: "../../MCCoordinator")
    ],
    targets: [
        .target(
            name: "MCSettings",
            dependencies: ["MCCoordinator"]),
        .testTarget(
            name: "MCSettingsTests",
            dependencies: ["MCSettings"]),
    ]
)

