// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureFavorites",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FeatureFavorites",
            targets: ["FeatureFavorites"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/michelgoni/NumbersEx", branch: "main"),
        .package(url: "https://github.com/michelgoni/NumbersUI", branch: "main"),
        .package(name: "Shared", path: "../Shared")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FeatureFavorites",
            dependencies: [.product(name: "Shared", package: "Shared"),
                           .product(name: "NumbersUI", package: "NumbersUI"),
                           .product(name: "NumbersEx", package: "NumbersEx")]),
        .testTarget(
            name: "FeatureFavoritesTests",
            dependencies: ["FeatureFavorites"]),
    ]
)
