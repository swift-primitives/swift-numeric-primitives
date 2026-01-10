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

extension Double: Numeric.Elementary {
    // MARK: - Protocol Requirements

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
    @inlinable public static func _erf(_ x: Double) -> Double { Numeric.Math.erf(x) }
    @inlinable public static func _erfc(_ x: Double) -> Double { Numeric.Math.erfc(x) }
    @inlinable public static func _tgamma(_ x: Double) -> Double { Numeric.Math.tgamma(x) }
}

// MARK: - Exponential Functions

extension Numeric.Math.Accessor where T == Double {
    /// e^x
    @inlinable
    public func exp(_ x: Double) -> Double { Numeric.Math.exp(x) }

    /// e^x - 1, accurate for small x
    @inlinable
    public func exp(minusOne x: Double) -> Double { Numeric.Math.expm1(x) }

    /// 2^x
    @inlinable
    public func exp2(_ x: Double) -> Double { Numeric.Math.exp2(x) }
}

// MARK: - Logarithmic Functions

extension Numeric.Math.Accessor where T == Double {
    /// Natural logarithm
    @inlinable
    public func log(_ x: Double) -> Double { Numeric.Math.log(x) }

    /// log(1+x), accurate for small x
    @inlinable
    public func log(onePlus x: Double) -> Double { Numeric.Math.log1p(x) }

    /// Base-2 logarithm
    @inlinable
    public func log2(_ x: Double) -> Double { Numeric.Math.log2(x) }

    /// Base-10 logarithm
    @inlinable
    public func log10(_ x: Double) -> Double { Numeric.Math.log10(x) }
}

// MARK: - Power Functions

extension Numeric.Math.Accessor where T == Double {
    /// x^y
    @inlinable
    public func pow(_ x: Double, _ y: Double) -> Double { Numeric.Math.pow(x, y) }

    /// Square root
    @inlinable
    public func sqrt(_ x: Double) -> Double { Numeric.Math.sqrt(x) }

    /// Cube root
    @inlinable
    public func cbrt(_ x: Double) -> Double { Numeric.Math.cbrt(x) }

    /// Hypotenuse: sqrt(x*x + y*y) without overflow
    @inlinable
    public func hypot(_ x: Double, _ y: Double) -> Double { Numeric.Math.hypot(x, y) }
}

// MARK: - Trigonometric Functions

extension Numeric.Math.Accessor where T == Double {
    /// Sine
    @inlinable
    public func sin(_ x: Double) -> Double { Numeric.Math.sin(x) }

    /// Cosine
    @inlinable
    public func cos(_ x: Double) -> Double { Numeric.Math.cos(x) }

    /// Tangent
    @inlinable
    public func tan(_ x: Double) -> Double { Numeric.Math.tan(x) }

    /// cos(x) - 1, accurate for small x
    ///
    /// Uses the identity: cos(x) - 1 = -2 * sin(x/2)^2
    @inlinable
    public func cos(minusOne x: Double) -> Double {
        let halfX = x / 2
        let sinHalf = Numeric.Math.sin(halfX)
        return -2 * sinHalf * sinHalf
    }
}

// MARK: - Inverse Trigonometric Functions

extension Numeric.Math.Accessor where T == Double {
    /// Arc sine
    @inlinable
    public func asin(_ x: Double) -> Double { Numeric.Math.asin(x) }

    /// Arc cosine
    @inlinable
    public func acos(_ x: Double) -> Double { Numeric.Math.acos(x) }

    /// Arc tangent
    @inlinable
    public func atan(_ x: Double) -> Double { Numeric.Math.atan(x) }

    /// Two-argument arc tangent
    @inlinable
    public func atan2(_ y: Double, _ x: Double) -> Double { Numeric.Math.atan2(y, x) }
}

// MARK: - Hyperbolic Functions

extension Numeric.Math.Accessor where T == Double {
    /// Hyperbolic sine
    @inlinable
    public func sinh(_ x: Double) -> Double { Numeric.Math.sinh(x) }

    /// Hyperbolic cosine
    @inlinable
    public func cosh(_ x: Double) -> Double { Numeric.Math.cosh(x) }

    /// Hyperbolic tangent
    @inlinable
    public func tanh(_ x: Double) -> Double { Numeric.Math.tanh(x) }
}

// MARK: - Inverse Hyperbolic Functions

extension Numeric.Math.Accessor where T == Double {
    /// Inverse hyperbolic sine
    @inlinable
    public func asinh(_ x: Double) -> Double { Numeric.Math.asinh(x) }

    /// Inverse hyperbolic cosine
    @inlinable
    public func acosh(_ x: Double) -> Double { Numeric.Math.acosh(x) }

    /// Inverse hyperbolic tangent
    @inlinable
    public func atanh(_ x: Double) -> Double { Numeric.Math.atanh(x) }
}

// MARK: - Special Functions

extension Numeric.Math.Accessor where T == Double {
    /// Error function
    @inlinable
    public func erf(_ x: Double) -> Double { Numeric.Math.erf(x) }

    /// Complementary error function
    @inlinable
    public func erfc(_ x: Double) -> Double { Numeric.Math.erfc(x) }

    /// Gamma function
    @inlinable
    public func tgamma(_ x: Double) -> Double { Numeric.Math.tgamma(x) }
}
