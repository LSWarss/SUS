// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SUS",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "SUS",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Logging", package: "swift-log")
            ],
            resources: [
                .process("Data")
            ]),
        .testTarget(
            name: "HelpersTests",
            dependencies: ["SUS"]),
        .testTarget(
            name: "UtilsTests",
            dependencies: ["SUS"]),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["SUS"]
        )
    ]
)
