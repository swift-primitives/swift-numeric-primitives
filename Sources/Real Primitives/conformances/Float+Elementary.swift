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

import _Shims

extension Float: Numeric.Elementary {
    // MARK: - Protocol Requirements

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
    @inlinable public static func _root(_ x: Float, _ n: Int) -> Float { Numeric.Math.root(x, n) }
    @inlinable public static func _hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }
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
    @inlinable public static func _erf(_ x: Float) -> Float { Numeric.Math.erf(x) }
    @inlinable public static func _erfc(_ x: Float) -> Float { Numeric.Math.erfc(x) }
    @inlinable public static func _tgamma(_ x: Float) -> Float { Numeric.Math.tgamma(x) }

    #if canImport(Darwin) || canImport(Glibc) || canImport(Musl)
    @inlinable public static func _logGamma(_ x: Float) -> Float { Numeric.Math.lgamma(x) }
    #endif

    // MARK: - Relaxed Arithmetic

    public static func _relaxedAdd(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_addf(a, b)
    }

    public static func _relaxedMul(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_mulf(a, b)
    }
}

// MARK: - Exponential Functions

extension Numeric.Math.Accessor where T == Float {
    /// Access exponential function and variants.
    @inlinable
    public var exp: Numeric.Math.Exp<Float> { .init() }

    /// 2^x
    @inlinable
    public func exp2(_ x: Float) -> Float { Numeric.Math.exp2(x) }
}

// MARK: - Logarithmic Functions

extension Numeric.Math.Accessor where T == Float {
    /// Access logarithm function and variants.
    @inlinable
    public var log: Numeric.Math.Log<Float> { .init() }

    /// Base-2 logarithm
    @inlinable
    public func log2(_ x: Float) -> Float { Numeric.Math.log2(x) }

    /// Base-10 logarithm
    @inlinable
    public func log10(_ x: Float) -> Float { Numeric.Math.log10(x) }
}

// MARK: - Power Functions

extension Numeric.Math.Accessor where T == Float {
    /// x^y
    @inlinable
    public func pow(_ x: Float, _ y: Float) -> Float { Numeric.Math.pow(x, y) }

    /// Square root
    @inlinable
    public func sqrt(_ x: Float) -> Float { Numeric.Math.sqrt(x) }

    /// Cube root
    @inlinable
    public func cbrt(_ x: Float) -> Float { Numeric.Math.cbrt(x) }

    /// The nth root of x.
    ///
    /// For negative x with odd n, returns the real nth root.
    /// For negative x with even n, returns NaN.
    @inlinable
    public func root(_ x: Float, _ n: Int) -> Float { Numeric.Math.root(x, n) }

    /// Hypotenuse: sqrt(x*x + y*y) without overflow
    @inlinable
    public func hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }
}

// MARK: - Trigonometric Functions

extension Numeric.Math.Accessor where T == Float {
    /// Sine
    @inlinable
    public func sin(_ x: Float) -> Float { Numeric.Math.sin(x) }

    /// Access cosine function and variants.
    @inlinable
    public var cos: Numeric.Math.Cos<Float> { .init() }

    /// Tangent
    @inlinable
    public func tan(_ x: Float) -> Float { Numeric.Math.tan(x) }
}

// MARK: - Inverse Trigonometric Functions

extension Numeric.Math.Accessor where T == Float {
    /// Arc sine
    @inlinable
    public func asin(_ x: Float) -> Float { Numeric.Math.asin(x) }

    /// Arc cosine
    @inlinable
    public func acos(_ x: Float) -> Float { Numeric.Math.acos(x) }

    /// Arc tangent
    @inlinable
    public func atan(_ x: Float) -> Float { Numeric.Math.atan(x) }

    /// Two-argument arc tangent
    @inlinable
    public func atan2(_ y: Float, _ x: Float) -> Float { Numeric.Math.atan2(y, x) }
}

// MARK: - Hyperbolic Functions

extension Numeric.Math.Accessor where T == Float {
    /// Hyperbolic sine
    @inlinable
    public func sinh(_ x: Float) -> Float { Numeric.Math.sinh(x) }

    /// Hyperbolic cosine
    @inlinable
    public func cosh(_ x: Float) -> Float { Numeric.Math.cosh(x) }

    /// Hyperbolic tangent
    @inlinable
    public func tanh(_ x: Float) -> Float { Numeric.Math.tanh(x) }
}

// MARK: - Inverse Hyperbolic Functions

extension Numeric.Math.Accessor where T == Float {
    /// Inverse hyperbolic sine
    @inlinable
    public func asinh(_ x: Float) -> Float { Numeric.Math.asinh(x) }

    /// Inverse hyperbolic cosine
    @inlinable
    public func acosh(_ x: Float) -> Float { Numeric.Math.acosh(x) }

    /// Inverse hyperbolic tangent
    @inlinable
    public func atanh(_ x: Float) -> Float { Numeric.Math.atanh(x) }
}

// MARK: - Special Functions

extension Numeric.Math.Accessor where T == Float {
    /// Error function
    @inlinable
    public func erf(_ x: Float) -> Float { Numeric.Math.erf(x) }

    /// Complementary error function
    @inlinable
    public func erfc(_ x: Float) -> Float { Numeric.Math.erfc(x) }

    /// Gamma function
    @inlinable
    public func tgamma(_ x: Float) -> Float { Numeric.Math.tgamma(x) }

    #if canImport(Darwin) || canImport(Glibc) || canImport(Musl)
    /// Logarithm of the absolute value of gamma function.
    ///
    /// Use together with `signGamma` to recover the sign.
    @inlinable
    public func logGamma(_ x: Float) -> Float { Numeric.Math.lgamma(x) }

    /// Sign of gamma function.
    ///
    /// - For x >= 0, returns `.plus`
    /// - For negative integers (poles), returns `.plus`
    /// - Otherwise alternates based on integral part
    @inlinable
    public func signGamma(_ x: Float) -> FloatingPointSign { Float._signGamma(x) }
    #endif
}
