# Numeric Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Numeric building blocks for Swift — sign and ternary classification, integer division and GCD/LCM, compensated (error-free) floating-point arithmetic, and platform `libm` transcendentals, with zero Foundation dependencies.

---

## Quick Start

`Numeric` is the ecosystem's root namespace for numeric types and operations. It groups four families: elementary functions on the real types (`Double.math.sin(_:)`, …), integer utilities (`gcd`, `lcm`, rounded `division`), error-compensated arithmetic that captures the rounding tail every IEEE 754 operation discards, and small classification types (`Numeric.Sign`, `Numeric.Ternary`). Everything is Foundation-free and Embedded-compatible.

```swift
import Numeric_Primitives

// Elementary functions via the `.math` accessor on a floating-point type.
let e = Double.math.exp(1.0)            // 2.718281828...

// Integer GCD / LCM.
let g = Numeric.Integer.gcd(24, 36)     // 12
let l = Numeric.Integer.lcm(4, 6)       // 12

// Rounded integer division — floor by default, or pick a rounding mode.
let floor = 17.division(by: 5)              // 3
let ceil = 17.division(by: 5, rounding: .up)  // 4
let (q, r) = 17.division.parts(by: 5)         // (3, 2)

// Compensated arithmetic: `head` is the rounded result, `tail` is the exact error.
let (head, tail) = Numeric.Augmented.sum(1e16, 1.0)  // head == 1e16, tail == 1.0

// Three-valued sign classification.
let s = Numeric.Sign(-5.0)              // .negative
```

`Numeric.Augmented` implements the classic error-free transforms (TwoSum, TwoProduct) used to build compensated summation and dot products; `Numeric.Relaxed` exposes the fast, fused counterparts. Higher-level packages compose these into matrices, decimals, and geometry; this package is the shared numeric core they build on.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-numeric-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Numeric Primitives", package: "swift-numeric-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Five library products plus a test-support product, built on `swift-tagged-primitives` and `swift-pair-primitives`.

| Product | Target | Purpose |
|---------|--------|---------|
| `Numeric Primitives` | `Sources/Numeric Primitives/` | Umbrella — re-exports Core, Real, Relaxed, and Integer. |
| `Numeric Primitives Core` | `Sources/Numeric Primitives Core/` | Core namespace: `Numeric.Sign`, `Numeric.Ternary`, `Numeric.Rounding`, `Numeric.Quantized`, `Numeric.Math`, and the `Transcendental` protocol. |
| `Real Primitives` | `Sources/Real Primitives/` | The `.math` accessor and `Transcendental` conformances on `Double` / `Float` / `Float16`, plus `Numeric.Augmented` (error-free transforms) and `Numeric.Fraction`. |
| `Numeric Relaxed Primitives` | `Sources/Numeric Relaxed Primitives/` | `Numeric.Relaxed` fast/fused arithmetic (`sum`, `product`, `multiplyAdd`). Carved out so `_Shims` does not leak through the Real interface. |
| `Integer Primitives` | `Sources/Integer Primitives/` | Integer `division` (all rounding modes), `gcd` / `lcm`, rotation, shift, saturating arithmetic, and the optional-producing `+?` operators. |
| `Numeric Primitives Test Support` | `Tests/Support/` | Re-exports the umbrella for test consumers. |

An internal `_Shims` C target wraps the platform `libm` symbols; it is not part of any public product's interface.

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported |

`Float16` transcendentals are available only on platform/architecture combinations that provide the underlying `libm` symbols (iOS / tvOS / watchOS / visionOS, and arm64 macOS / Mac Catalyst).

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
