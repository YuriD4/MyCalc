// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCCalculator",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MCCalculator",
            targets: ["MCCalculator"]),
    ],
    dependencies: [
        .package(path: "../../MCCoordinator"),
        .package(path: "../../Environment"),
        .package(path: "../../Networking")
    ],
    targets: [
        .target(
            name: "MCCalculator",
            dependencies: ["MCCoordinator", "Networking"]),
        .testTarget(
            name: "MCCalculatorTests",
            dependencies: ["MCCalculator"]),
    ]
)


