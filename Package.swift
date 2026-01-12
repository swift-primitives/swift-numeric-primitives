// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-numeric-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(name: "Numeric Primitives", targets: ["Numeric Primitives"]),
        .library(name: "Real Primitives", targets: ["Real Primitives"]),
        .library(name: "Integer Primitives", targets: ["Integer Primitives"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-identity-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-test-primitives.git", from: "0.0.1"),
    ],
    targets: [
        // C shims for libm (internal only)
        .target(
            name: "_Shims",
            publicHeadersPath: "include"
        ),

        // Core module
        .target(
            name: "Numeric Primitives",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
            ]
        ),

        // Real number functions
        .target(
            name: "Real Primitives",
            dependencies: ["Numeric Primitives", "_Shims"]
        ),

        // Integer utilities
        .target(
            name: "Integer Primitives",
            dependencies: ["Numeric Primitives"]
        ),

        // Tests
        .testTarget(
            name: "Real Primitives Tests",
            dependencies: [
                "Real Primitives",
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
        .testTarget(
            name: "Integer Primitives Tests",
            dependencies: [
                "Integer Primitives",
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
    ]
}
