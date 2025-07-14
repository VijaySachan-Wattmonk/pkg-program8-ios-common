// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pkg-program8-ios-common",
    platforms: [
            .iOS(.v15) // This means your package supports iOS 15 and later
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "pkg-program8-ios-common",
            targets: ["pkg-program8-ios-common"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "pkg-program8-ios-common"),
        .testTarget(
            name: "pkg-program8-ios-commonTests",
            dependencies: ["pkg-program8-ios-common"]
        ),
    ]
)
