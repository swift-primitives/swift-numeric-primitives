// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-numeric-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(name: "Numeric Primitives", targets: ["Numeric Primitives"]),
        .library(name: "Numeric Primitives Core", targets: ["Numeric Primitives Core"]),
        .library(name: "Real Primitives", targets: ["Real Primitives"]),
        .library(name: "Integer Primitives", targets: ["Integer Primitives"]),
        .library(
            name: "Numeric Primitives Test Support",
            targets: ["Numeric Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-identity-primitives")
    ],
    targets: [
        // C shims for libm (internal only)
        .target(
            name: "_Shims",
            publicHeadersPath: "include"
        ),

        // MARK: - Core
        .target(
            name: "Numeric Primitives Core",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives")
            ]
        ),

        // MARK: - Real
        .target(
            name: "Real Primitives",
            dependencies: ["Numeric Primitives Core", "_Shims"]
        ),

        // MARK: - Integer
        .target(
            name: "Integer Primitives",
            dependencies: ["Numeric Primitives Core"]
        ),

        // MARK: - Umbrella
        .target(
            name: "Numeric Primitives",
            dependencies: [
                "Numeric Primitives Core",
                "Real Primitives",
                "Integer Primitives",
            ]
        ),
        .testTarget(
            name: "Real Primitives Tests",
            dependencies: [
                "Real Primitives",
            ]
        ),
        .testTarget(
            name: "Integer Primitives Tests",
            dependencies: [
                "Integer Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Numeric Primitives Test Support",
            dependencies: [
                "Numeric Primitives",
                .product(name: "Identity Primitives Test Support", package: "swift-identity-primitives"),
            ],
            path: "Tests/Support"
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
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableExperimentalFeature("SuppressedAssociatedTypesWithDefaults"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
