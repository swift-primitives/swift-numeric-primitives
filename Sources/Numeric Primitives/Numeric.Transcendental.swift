// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2025 Coen ten Thije Boonkkamp and the swift-primitives
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

/// A type that supports transcendental mathematical operations.
///
/// Transcendental functions (sin, cos, exp, log) are functions that cannot be
/// expressed as finite combinations of algebraic operations. This protocol
/// describes the *capability* of supporting these operations, independent of
/// numeric representation.
///
/// ## Design Principle
///
/// `Transcendental` is a capability marker, not a representation requirement.
/// Use protocol composition to combine with representation protocols:
///
/// ```swift
/// // IEEE 754 floating-point with transcendental support
/// where Scalar: BinaryFloatingPoint & Numeric.Transcendental
/// ```
///
/// ## Conformance Rules
///
/// Conformance is provided by Real Primitives for types with stable libm support:
/// - `Double` — 64-bit IEEE 754 binary64
/// - `Float` — 32-bit IEEE 754 binary32
/// - `Float16` — 16-bit IEEE 754 binary16 (platform-conditional)
///
/// Custom types should only conform if they provide semantically equivalent
/// implementations of all transcendental operations.
///
/// ## Performance Model
///
/// This protocol uses explicit static methods with `@inlinable` to maximize
/// specialization opportunities. In optimized builds (`-O`), all calls should
/// resolve to direct function calls with no protocol witness overhead.
public protocol Transcendental {
    // MARK: - Trigonometric Functions

    /// Sine function.
    static func _sin(_ x: Self) -> Self

    /// Cosine function.
    static func _cos(_ x: Self) -> Self

    /// Tangent function.
    static func _tan(_ x: Self) -> Self

    // MARK: - Inverse Trigonometric Functions

    /// Arc sine (inverse sine).
    static func _asin(_ x: Self) -> Self

    /// Arc cosine (inverse cosine).
    static func _acos(_ x: Self) -> Self

    /// Arc tangent (inverse tangent).
    static func _atan(_ x: Self) -> Self

    /// Two-argument arc tangent for quadrant-aware angle computation.
    static func _atan2(_ y: Self, _ x: Self) -> Self

    // MARK: - Hyperbolic Functions

    /// Hyperbolic sine.
    static func _sinh(_ x: Self) -> Self

    /// Hyperbolic cosine.
    static func _cosh(_ x: Self) -> Self

    /// Hyperbolic tangent.
    static func _tanh(_ x: Self) -> Self

    // MARK: - Inverse Hyperbolic Functions

    /// Inverse hyperbolic sine.
    static func _asinh(_ x: Self) -> Self

    /// Inverse hyperbolic cosine.
    static func _acosh(_ x: Self) -> Self

    /// Inverse hyperbolic tangent.
    static func _atanh(_ x: Self) -> Self

    // MARK: - Exponential and Logarithmic Functions

    /// Exponential function (e^x).
    static func _exp(_ x: Self) -> Self

    /// e^x - 1, accurate for small x.
    static func _expm1(_ x: Self) -> Self

    /// 2^x.
    static func _exp2(_ x: Self) -> Self

    /// Natural logarithm (ln x).
    static func _log(_ x: Self) -> Self

    /// ln(1+x), accurate for small x.
    static func _log1p(_ x: Self) -> Self

    /// Base-2 logarithm.
    static func _log2(_ x: Self) -> Self

    /// Base-10 logarithm.
    static func _log10(_ x: Self) -> Self

    // MARK: - Power Functions

    /// x raised to the power y.
    static func _pow(_ x: Self, _ y: Self) -> Self

    /// Square root.
    static func _sqrt(_ x: Self) -> Self

    /// Cube root.
    static func _cbrt(_ x: Self) -> Self

    /// Hypotenuse: sqrt(x² + y²) without overflow.
    static func _hypot(_ x: Self, _ y: Self) -> Self

    // MARK: - Accessor (User-Facing API)

    /// Access to mathematical functions via the accessor pattern.
    ///
    /// This is the preferred user-facing API. The explicit static functions
    /// above exist to give the optimizer a clear call graph.
    static var math: Numeric.Math.Accessor<Self> { get }
}
