// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PatternsCore",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "PatternsCore", targets: ["PatternsCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.9.0"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.19"),
    ],
    targets: [
        .target(
            name: "PatternsCore",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
            ]
        ),
        .testTarget(
            name: "PatternsCoreTests",
            dependencies: ["PatternsCore"]
        ),
    ]
)
