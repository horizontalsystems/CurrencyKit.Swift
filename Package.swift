// swift-tools-version:5.5

import PackageDescription

let package = Package(
        name: "CurrencyKit",
        platforms: [
            .iOS(.v13),
        ],
        products: [
            .library(
                    name: "CurrencyKit",
                    targets: ["CurrencyKit"]),
        ],
        dependencies: [
            .package(url: "https://github.com/horizontalsystems/StorageKit.Swift.git", .upToNextMajor(from: "2.0.0")),
        ],
        targets: [
            .target(
                    name: "CurrencyKit",
                    dependencies: [
                        .product(name: "StorageKit", package: "StorageKit.Swift"),
                    ]
            )
        ]
)
