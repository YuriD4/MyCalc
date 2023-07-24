// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCSharedUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MCSharedUI",
            targets: ["MCSharedUI"]),
    ],
    targets: [
        .target(
            name: "MCSharedUI",
            dependencies: []),
        .testTarget(
            name: "MCSharedUITests",
            dependencies: ["MCSharedUI"]),
    ]
)
