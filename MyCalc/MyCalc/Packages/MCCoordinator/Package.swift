// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCCoordinator",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MCCoordinator",
            targets: ["MCCoordinator"]),
    ],
    targets: [
        .target(
            name: "MCCoordinator",
            dependencies: []),
        .testTarget(
            name: "MCCoordinatorTests",
            dependencies: ["MCCoordinator"]),
    ]
)


