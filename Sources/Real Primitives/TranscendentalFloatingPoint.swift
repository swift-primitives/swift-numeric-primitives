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

/// A floating-point type with platform-native transcendental function support.
///
/// This protocol is a **libm binding contract**, not a general numeric capability.
/// It bridges the gap between `BinaryFloatingPoint` (which has no transcendental
/// functions) and the concrete implementations provided by Darwin/Glibc/musl.
///
/// ## Conformance Rules
///
/// **Only types with stable libm support may conform.**
///
/// Conformance is restricted to:
/// - `Double` — 64-bit IEEE 754 binary64
/// - `Float` — 32-bit IEEE 754 binary32
/// - `Float16` — 16-bit IEEE 754 binary16 (platform-conditional)
///
/// Custom floating-point types, decimal floats, and approximate implementations
/// **must not** conform. This prevents semantic mismatches where, for example,
/// an approximate `sin` implementation silently produces different results.
///
/// ## Performance Model
///
/// This protocol uses explicit static methods with `@inlinable` to maximize
/// specialization opportunities. In optimized builds (`-O`), all calls should
/// resolve to direct function calls with no protocol witness overhead.
///
/// **Note:** "Zero overhead" means zero overhead *after specialization in
/// optimized builds*. Unoptimized builds or non-specialized generic contexts
/// may still use protocol witness tables.
///
/// ## Why "Transcendental"?
///
/// The name signals that this is platform math (libm), not algebraic math.
/// Transcendental functions (sin, cos, exp, log) are fundamentally different
/// from algebraic operations (+, -, *, /, squareRoot) because they cannot be
/// computed by finite algebraic expressions.
public protocol TranscendentalFloatingPoint: BinaryFloatingPoint {
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

// MARK: - Double Conformance

extension Double: TranscendentalFloatingPoint {
    @inlinable public static func _sin(_ x: Double) -> Double { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Double) -> Double { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Double) -> Double { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Double) -> Double { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Double) -> Double { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Double) -> Double { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Double, _ x: Double) -> Double { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Double) -> Double { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Double) -> Double { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Double) -> Double { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Double) -> Double { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Double) -> Double { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Double) -> Double { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Double) -> Double { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Double) -> Double { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Double) -> Double { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Double) -> Double { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Double) -> Double { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Double) -> Double { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Double) -> Double { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Double, _ y: Double) -> Double { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Double) -> Double { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Double) -> Double { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Double, _ y: Double) -> Double { Numeric.Math.hypot(x, y) }
}

// MARK: - Float Conformance

extension Float: TranscendentalFloatingPoint {
    @inlinable public static func _sin(_ x: Float) -> Float { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Float) -> Float { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Float) -> Float { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Float) -> Float { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Float) -> Float { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Float) -> Float { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Float, _ x: Float) -> Float { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Float) -> Float { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Float) -> Float { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Float) -> Float { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Float) -> Float { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Float) -> Float { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Float) -> Float { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Float) -> Float { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Float) -> Float { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Float) -> Float { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Float) -> Float { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Float) -> Float { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Float) -> Float { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Float) -> Float { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Float, _ y: Float) -> Float { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Float) -> Float { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Float) -> Float { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }
}

// MARK: - Float16 Conformance (Platform-Conditional)

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
extension Float16: TranscendentalFloatingPoint {
    @inlinable public static func _sin(_ x: Float16) -> Float16 { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Float16) -> Float16 { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Float16) -> Float16 { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Float16) -> Float16 { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Float16) -> Float16 { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Float16) -> Float16 { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Float16, _ x: Float16) -> Float16 { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Float16) -> Float16 { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Float16) -> Float16 { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Float16) -> Float16 { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Float16) -> Float16 { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Float16) -> Float16 { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Float16) -> Float16 { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Float16) -> Float16 { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Float16) -> Float16 { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Float16) -> Float16 { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Float16) -> Float16 { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Float16) -> Float16 { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Float16) -> Float16 { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Float16) -> Float16 { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Float16) -> Float16 { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Float16) -> Float16 { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.hypot(x, y) }
}
#endif
