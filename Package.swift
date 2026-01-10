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
        .library(name: "Complex Primitives", targets: ["Complex Primitives"]),
        .library(name: "Integer Primitives", targets: ["Integer Primitives"]),
    ],
    dependencies: [
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-test-support-primitives"),
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

        // Complex numbers
        .target(
            name: "Complex Primitives",
            dependencies: ["Real Primitives"]
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
                .product(name: "Test Support Primitives", package: "swift-test-support-primitives"),
            ]
        ),
        .testTarget(
            name: "Complex Primitives Tests",
            dependencies: [
                "Complex Primitives",
                .product(name: "Test Support Primitives", package: "swift-test-support-primitives"),
            ]
        ),
        .testTarget(
            name: "Integer Primitives Tests",
            dependencies: [
                "Integer Primitives",
                .product(name: "Test Support Primitives", package: "swift-test-support-primitives"),
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
