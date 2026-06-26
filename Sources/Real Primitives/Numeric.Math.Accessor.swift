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

public import Numeric_Primitives_Core

// MARK: - Double

extension Double {
    /// Zero-sized token providing math operations.
    @inlinable
    public static var math: Numeric.Math.Accessor<Double> { .init() }
}

extension Numeric.Math.Accessor where T == Double {
    // Exponential Functions

    /// Base-e exponential, e^x.
    @inlinable
    public func exp(_ x: Double) -> Double { Numeric.Math.exp(x) }

    /// e^x - 1, accurate for small x.
    @inlinable
    public func expm1(_ x: Double) -> Double { Numeric.Math.expm1(x) }

    /// Base-2 exponential, 2^x.
    @inlinable
    public func exp2(_ x: Double) -> Double { Numeric.Math.exp2(x) }

    // Logarithmic Functions

    /// Natural logarithm ln(x).
    @inlinable
    public func log(_ x: Double) -> Double { Numeric.Math.log(x) }

    /// ln(1+x), accurate for small x.
    @inlinable
    public func log1p(_ x: Double) -> Double { Numeric.Math.log1p(x) }

    /// Base-2 logarithm.
    @inlinable
    public func log2(_ x: Double) -> Double { Numeric.Math.log2(x) }

    /// Base-10 logarithm.
    @inlinable
    public func log10(_ x: Double) -> Double { Numeric.Math.log10(x) }

    // Power Functions

    /// x raised to the power y.
    @inlinable
    public func pow(_ x: Double, _ y: Double) -> Double { Numeric.Math.pow(x, y) }

    /// Square root.
    @inlinable
    public func sqrt(_ x: Double) -> Double { Numeric.Math.sqrt(x) }

    /// Cube root.
    @inlinable
    public func cbrt(_ x: Double) -> Double { Numeric.Math.cbrt(x) }

    /// Hypotenuse: sqrt(x² + y²) without overflow.
    @inlinable
    public func hypot(_ x: Double, _ y: Double) -> Double { Numeric.Math.hypot(x, y) }

    /// nth root.
    @inlinable
    public func root(_ x: Double, _ n: Int) -> Double { Numeric.Math.root(x, n) }

    // Trigonometric Functions

    /// Sine.
    @inlinable
    public func sin(_ x: Double) -> Double { Numeric.Math.sin(x) }

    /// Cosine.
    @inlinable
    public func cos(_ x: Double) -> Double { Numeric.Math.cos(x) }

    /// Tangent.
    @inlinable
    public func tan(_ x: Double) -> Double { Numeric.Math.tan(x) }

    // Inverse Trigonometric Functions

    /// Arc sine.
    @inlinable
    public func asin(_ x: Double) -> Double { Numeric.Math.asin(x) }

    /// Arc cosine.
    @inlinable
    public func acos(_ x: Double) -> Double { Numeric.Math.acos(x) }

    /// Arc tangent.
    @inlinable
    public func atan(_ x: Double) -> Double { Numeric.Math.atan(x) }

    /// Two-argument arc tangent.
    @inlinable
    public func atan2(_ y: Double, _ x: Double) -> Double { Numeric.Math.atan2(y, x) }

    // Hyperbolic Functions

    /// Hyperbolic sine.
    @inlinable
    public func sinh(_ x: Double) -> Double { Numeric.Math.sinh(x) }

    /// Hyperbolic cosine.
    @inlinable
    public func cosh(_ x: Double) -> Double { Numeric.Math.cosh(x) }

    /// Hyperbolic tangent.
    @inlinable
    public func tanh(_ x: Double) -> Double { Numeric.Math.tanh(x) }

    // Inverse Hyperbolic Functions

    /// Inverse hyperbolic sine.
    @inlinable
    public func asinh(_ x: Double) -> Double { Numeric.Math.asinh(x) }

    /// Inverse hyperbolic cosine.
    @inlinable
    public func acosh(_ x: Double) -> Double { Numeric.Math.acosh(x) }

    /// Inverse hyperbolic tangent.
    @inlinable
    public func atanh(_ x: Double) -> Double { Numeric.Math.atanh(x) }

    // Special Functions

    /// Error function.
    @inlinable
    public func erf(_ x: Double) -> Double { Numeric.Math.erf(x) }

    /// Complementary error function.
    @inlinable
    public func erfc(_ x: Double) -> Double { Numeric.Math.erfc(x) }

    /// Gamma function.
    @inlinable
    public func tgamma(_ x: Double) -> Double { Numeric.Math.tgamma(x) }

    // `lgamma` / `logGamma` relocated to swift-numerics (L3) per /platform
    // [PLAT-ARCH-008c] — see Numerics/Numeric.Math.LogGamma.swift.
}

// MARK: - Float

extension Float {
    /// Zero-sized token providing math operations.
    @inlinable
    public static var math: Numeric.Math.Accessor<Float> { .init() }
}

extension Numeric.Math.Accessor where T == Float {
    // Exponential Functions

    /// Base-e exponential, e^x.
    @inlinable
    public func exp(_ x: Float) -> Float { Numeric.Math.exp(x) }

    /// e^x - 1, accurate for small x.
    @inlinable
    public func expm1(_ x: Float) -> Float { Numeric.Math.expm1(x) }

    /// Base-2 exponential, 2^x.
    @inlinable
    public func exp2(_ x: Float) -> Float { Numeric.Math.exp2(x) }

    // Logarithmic Functions

    /// Natural logarithm ln(x).
    @inlinable
    public func log(_ x: Float) -> Float { Numeric.Math.log(x) }

    /// ln(1+x), accurate for small x.
    @inlinable
    public func log1p(_ x: Float) -> Float { Numeric.Math.log1p(x) }

    /// Base-2 logarithm.
    @inlinable
    public func log2(_ x: Float) -> Float { Numeric.Math.log2(x) }

    /// Base-10 logarithm.
    @inlinable
    public func log10(_ x: Float) -> Float { Numeric.Math.log10(x) }

    // Power Functions

    /// x raised to the power y.
    @inlinable
    public func pow(_ x: Float, _ y: Float) -> Float { Numeric.Math.pow(x, y) }

    /// Square root.
    @inlinable
    public func sqrt(_ x: Float) -> Float { Numeric.Math.sqrt(x) }

    /// Cube root.
    @inlinable
    public func cbrt(_ x: Float) -> Float { Numeric.Math.cbrt(x) }

    /// Hypotenuse: sqrt(x² + y²) without overflow.
    @inlinable
    public func hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }

    /// nth root.
    @inlinable
    public func root(_ x: Float, _ n: Int) -> Float { Numeric.Math.root(x, n) }

    // Trigonometric Functions

    /// Sine.
    @inlinable
    public func sin(_ x: Float) -> Float { Numeric.Math.sin(x) }

    /// Cosine.
    @inlinable
    public func cos(_ x: Float) -> Float { Numeric.Math.cos(x) }

    /// Tangent.
    @inlinable
    public func tan(_ x: Float) -> Float { Numeric.Math.tan(x) }

    // Inverse Trigonometric Functions

    /// Arc sine.
    @inlinable
    public func asin(_ x: Float) -> Float { Numeric.Math.asin(x) }

    /// Arc cosine.
    @inlinable
    public func acos(_ x: Float) -> Float { Numeric.Math.acos(x) }

    /// Arc tangent.
    @inlinable
    public func atan(_ x: Float) -> Float { Numeric.Math.atan(x) }

    /// Two-argument arc tangent.
    @inlinable
    public func atan2(_ y: Float, _ x: Float) -> Float { Numeric.Math.atan2(y, x) }

    // Hyperbolic Functions

    /// Hyperbolic sine.
    @inlinable
    public func sinh(_ x: Float) -> Float { Numeric.Math.sinh(x) }

    /// Hyperbolic cosine.
    @inlinable
    public func cosh(_ x: Float) -> Float { Numeric.Math.cosh(x) }

    /// Hyperbolic tangent.
    @inlinable
    public func tanh(_ x: Float) -> Float { Numeric.Math.tanh(x) }

    // Inverse Hyperbolic Functions

    /// Inverse hyperbolic sine.
    @inlinable
    public func asinh(_ x: Float) -> Float { Numeric.Math.asinh(x) }

    /// Inverse hyperbolic cosine.
    @inlinable
    public func acosh(_ x: Float) -> Float { Numeric.Math.acosh(x) }

    /// Inverse hyperbolic tangent.
    @inlinable
    public func atanh(_ x: Float) -> Float { Numeric.Math.atanh(x) }

    // Special Functions

    /// Error function.
    @inlinable
    public func erf(_ x: Float) -> Float { Numeric.Math.erf(x) }

    /// Complementary error function.
    @inlinable
    public func erfc(_ x: Float) -> Float { Numeric.Math.erfc(x) }

    /// Gamma function.
    @inlinable
    public func tgamma(_ x: Float) -> Float { Numeric.Math.tgamma(x) }

    // `lgamma` / `logGamma` relocated to swift-numerics (L3) per /platform
    // [PLAT-ARCH-008c] — see Numerics/Numeric.Math.LogGamma.swift.
}

// MARK: - Float16

// swiftlint:disable:next l1_no_platform_conditionals - reason: Float16 math accessor depends on the Float16 libm shims available only on the listed platform/arch combinations; the extension cannot compile where Float16 hardware math is absent.
#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
    extension Float16 {
        /// Zero-sized token providing math operations.
        @inlinable
        public static var math: Numeric.Math.Accessor<Float16> { .init() }
    }

    extension Numeric.Math.Accessor where T == Float16 {
        // Exponential Functions

        /// Base-e exponential, e^x.
        @inlinable
        public func exp(_ x: Float16) -> Float16 { Numeric.Math.exp(x) }

        /// e^x - 1, accurate for small x.
        @inlinable
        public func expm1(_ x: Float16) -> Float16 { Numeric.Math.expm1(x) }

        /// Base-2 exponential, 2^x.
        @inlinable
        public func exp2(_ x: Float16) -> Float16 { Numeric.Math.exp2(x) }

        // Logarithmic Functions

        /// Natural logarithm ln(x).
        @inlinable
        public func log(_ x: Float16) -> Float16 { Numeric.Math.log(x) }

        /// ln(1+x), accurate for small x.
        @inlinable
        public func log1p(_ x: Float16) -> Float16 { Numeric.Math.log1p(x) }

        /// Base-2 logarithm.
        @inlinable
        public func log2(_ x: Float16) -> Float16 { Numeric.Math.log2(x) }

        /// Base-10 logarithm.
        @inlinable
        public func log10(_ x: Float16) -> Float16 { Numeric.Math.log10(x) }

        // Power Functions

        /// x raised to the power y.
        @inlinable
        public func pow(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.pow(x, y) }

        /// Square root.
        @inlinable
        public func sqrt(_ x: Float16) -> Float16 { Numeric.Math.sqrt(x) }

        /// Cube root.
        @inlinable
        public func cbrt(_ x: Float16) -> Float16 { Numeric.Math.cbrt(x) }

        /// nth root.
        @inlinable
        public func root(_ x: Float16, _ n: Int) -> Float16 { Numeric.Math.root(x, n) }

        /// Hypotenuse: sqrt(x² + y²) without overflow.
        @inlinable
        public func hypot(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.hypot(x, y) }

        // Trigonometric Functions

        /// Sine.
        @inlinable
        public func sin(_ x: Float16) -> Float16 { Numeric.Math.sin(x) }

        /// Cosine.
        @inlinable
        public func cos(_ x: Float16) -> Float16 { Numeric.Math.cos(x) }

        /// Tangent.
        @inlinable
        public func tan(_ x: Float16) -> Float16 { Numeric.Math.tan(x) }

        // Inverse Trigonometric Functions

        /// Arc sine.
        @inlinable
        public func asin(_ x: Float16) -> Float16 { Numeric.Math.asin(x) }

        /// Arc cosine.
        @inlinable
        public func acos(_ x: Float16) -> Float16 { Numeric.Math.acos(x) }

        /// Arc tangent.
        @inlinable
        public func atan(_ x: Float16) -> Float16 { Numeric.Math.atan(x) }

        /// Two-argument arc tangent.
        @inlinable
        public func atan2(_ y: Float16, _ x: Float16) -> Float16 { Numeric.Math.atan2(y, x) }

        // Hyperbolic Functions

        /// Hyperbolic sine.
        @inlinable
        public func sinh(_ x: Float16) -> Float16 { Numeric.Math.sinh(x) }

        /// Hyperbolic cosine.
        @inlinable
        public func cosh(_ x: Float16) -> Float16 { Numeric.Math.cosh(x) }

        /// Hyperbolic tangent.
        @inlinable
        public func tanh(_ x: Float16) -> Float16 { Numeric.Math.tanh(x) }

        // Inverse Hyperbolic Functions

        /// Inverse hyperbolic sine.
        @inlinable
        public func asinh(_ x: Float16) -> Float16 { Numeric.Math.asinh(x) }

        /// Inverse hyperbolic cosine.
        @inlinable
        public func acosh(_ x: Float16) -> Float16 { Numeric.Math.acosh(x) }

        /// Inverse hyperbolic tangent.
        @inlinable
        public func atanh(_ x: Float16) -> Float16 { Numeric.Math.atanh(x) }

        // Special Functions

        /// Error function.
        @inlinable
        public func erf(_ x: Float16) -> Float16 { Numeric.Math.erf(x) }

        /// Complementary error function.
        @inlinable
        public func erfc(_ x: Float16) -> Float16 { Numeric.Math.erfc(x) }

        /// Gamma function.
        @inlinable
        public func tgamma(_ x: Float16) -> Float16 { Numeric.Math.tgamma(x) }

        // `lgamma` / `logGamma` relocated to swift-numerics (L3) per /platform
        // [PLAT-ARCH-008c] — see Numerics/Numeric.Math.LogGamma.swift.
    }
#endif
