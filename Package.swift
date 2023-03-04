// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenAIService",
    platforms: [
        .iOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "OpenAIService",
            targets: ["OpenAIService"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OpenAIService",
            dependencies: []),
        .testTarget(
            name: "OpenAIServiceTests",
            dependencies: ["OpenAIService"]),
    ]
)
