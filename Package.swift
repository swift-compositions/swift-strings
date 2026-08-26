// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-strings",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Strings",
            targets: ["Strings"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-string.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-iso/swift-iso-9899.git", branch: "main"),
        .package(
            url: "https://github.com/swift-molecules/swift-ascii-serializer.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Strings",
            dependencies: [
                .product(name: "String", package: "swift-string"),
                .product(name: "ISO 9899", package: "swift-iso-9899"),
                .product(
                    name: "ASCII Hexadecimal Serializer",
                    package: "swift-ascii-serializer"
                ),
            ],
            swiftSettings: [
                .enableExperimentalFeature("Lifetimes")
            ]
        ),
        .testTarget(
            name: "Strings Tests",
            dependencies: [
                "Strings"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
