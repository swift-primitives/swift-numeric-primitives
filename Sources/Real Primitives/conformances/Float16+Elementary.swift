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

// Float16 is only available on arm64 macOS, not on x86_64.
#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: Numeric.Elementary {
    // MARK: - Protocol Requirements
    // All operations delegate to Float and convert back.

    @inlinable public static func _exp(_ x: Float16) -> Float16 { Float16(Float._exp(Float(x))) }
    @inlinable public static func _expm1(_ x: Float16) -> Float16 { Float16(Float._expm1(Float(x))) }
    @inlinable public static func _exp2(_ x: Float16) -> Float16 { Float16(Float._exp2(Float(x))) }
    @inlinable public static func _log(_ x: Float16) -> Float16 { Float16(Float._log(Float(x))) }
    @inlinable public static func _log1p(_ x: Float16) -> Float16 { Float16(Float._log1p(Float(x))) }
    @inlinable public static func _log2(_ x: Float16) -> Float16 { Float16(Float._log2(Float(x))) }
    @inlinable public static func _log10(_ x: Float16) -> Float16 { Float16(Float._log10(Float(x))) }
    @inlinable public static func _pow(_ x: Float16, _ y: Float16) -> Float16 { Float16(Float._pow(Float(x), Float(y))) }
    @inlinable public static func _sqrt(_ x: Float16) -> Float16 { Float16(Float._sqrt(Float(x))) }
    @inlinable public static func _cbrt(_ x: Float16) -> Float16 { Float16(Float._cbrt(Float(x))) }
    @inlinable public static func _root(_ x: Float16, _ n: Int) -> Float16 { Float16(Float._root(Float(x), n)) }

    @inlinable public static func _hypot(_ x: Float16, _ y: Float16) -> Float16 {
        // Handle infinities explicitly for Float16
        if x.isInfinite || y.isInfinite { return .infinity }
        return Float16(Float._hypot(Float(x), Float(y)))
    }

    @inlinable public static func _sin(_ x: Float16) -> Float16 { Float16(Float._sin(Float(x))) }
    @inlinable public static func _cos(_ x: Float16) -> Float16 { Float16(Float._cos(Float(x))) }
    @inlinable public static func _tan(_ x: Float16) -> Float16 { Float16(Float._tan(Float(x))) }
    @inlinable public static func _asin(_ x: Float16) -> Float16 { Float16(Float._asin(Float(x))) }
    @inlinable public static func _acos(_ x: Float16) -> Float16 { Float16(Float._acos(Float(x))) }
    @inlinable public static func _atan(_ x: Float16) -> Float16 { Float16(Float._atan(Float(x))) }
    @inlinable public static func _atan2(_ y: Float16, _ x: Float16) -> Float16 { Float16(Float._atan2(Float(y), Float(x))) }
    @inlinable public static func _sinh(_ x: Float16) -> Float16 { Float16(Float._sinh(Float(x))) }
    @inlinable public static func _cosh(_ x: Float16) -> Float16 { Float16(Float._cosh(Float(x))) }
    @inlinable public static func _tanh(_ x: Float16) -> Float16 { Float16(Float._tanh(Float(x))) }
    @inlinable public static func _asinh(_ x: Float16) -> Float16 { Float16(Float._asinh(Float(x))) }
    @inlinable public static func _acosh(_ x: Float16) -> Float16 { Float16(Float._acosh(Float(x))) }
    @inlinable public static func _atanh(_ x: Float16) -> Float16 { Float16(Float._atanh(Float(x))) }
    @inlinable public static func _erf(_ x: Float16) -> Float16 { Float16(Float._erf(Float(x))) }
    @inlinable public static func _erfc(_ x: Float16) -> Float16 { Float16(Float._erfc(Float(x))) }
    @inlinable public static func _tgamma(_ x: Float16) -> Float16 { Float16(Float._tgamma(Float(x))) }

    #if !os(Windows)
    @inlinable public static func _logGamma(_ x: Float16) -> Float16 { Float16(Float._logGamma(Float(x))) }
    #endif

    // MARK: - Relaxed Arithmetic
    // For Float16, relaxed operations fall back to strict (default implementation).
    // Native Float16 relaxed shims could be added for platforms that support _Float16.
}

// MARK: - Exponential Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// e^x
    @inlinable
    public func exp(_ x: Float16) -> Float16 { Float16._exp(x) }

    /// e^x - 1, accurate for small x
    @inlinable
    public func exp(minusOne x: Float16) -> Float16 { Float16._expm1(x) }

    /// 2^x
    @inlinable
    public func exp2(_ x: Float16) -> Float16 { Float16._exp2(x) }
}

// MARK: - Logarithmic Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Natural logarithm
    @inlinable
    public func log(_ x: Float16) -> Float16 { Float16._log(x) }

    /// log(1+x), accurate for small x
    @inlinable
    public func log(onePlus x: Float16) -> Float16 { Float16._log1p(x) }

    /// Base-2 logarithm
    @inlinable
    public func log2(_ x: Float16) -> Float16 { Float16._log2(x) }

    /// Base-10 logarithm
    @inlinable
    public func log10(_ x: Float16) -> Float16 { Float16._log10(x) }
}

// MARK: - Power Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// x^y
    @inlinable
    public func pow(_ x: Float16, _ y: Float16) -> Float16 { Float16._pow(x, y) }

    /// Square root
    @inlinable
    public func sqrt(_ x: Float16) -> Float16 { Float16._sqrt(x) }

    /// Cube root
    @inlinable
    public func cbrt(_ x: Float16) -> Float16 { Float16._cbrt(x) }

    /// The nth root of x.
    @inlinable
    public func root(_ x: Float16, _ n: Int) -> Float16 { Float16._root(x, n) }

    /// Hypotenuse: sqrt(x*x + y*y) without overflow
    @inlinable
    public func hypot(_ x: Float16, _ y: Float16) -> Float16 { Float16._hypot(x, y) }
}

// MARK: - Trigonometric Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Sine
    @inlinable
    public func sin(_ x: Float16) -> Float16 { Float16._sin(x) }

    /// Cosine
    @inlinable
    public func cos(_ x: Float16) -> Float16 { Float16._cos(x) }

    /// Tangent
    @inlinable
    public func tan(_ x: Float16) -> Float16 { Float16._tan(x) }

    /// cos(x) - 1, accurate for small x
    @inlinable
    public func cos(minusOne x: Float16) -> Float16 {
        let halfX = x / 2
        let sinHalf = Float16._sin(halfX)
        return -2 * sinHalf * sinHalf
    }
}

// MARK: - Inverse Trigonometric Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Arc sine
    @inlinable
    public func asin(_ x: Float16) -> Float16 { Float16._asin(x) }

    /// Arc cosine
    @inlinable
    public func acos(_ x: Float16) -> Float16 { Float16._acos(x) }

    /// Arc tangent
    @inlinable
    public func atan(_ x: Float16) -> Float16 { Float16._atan(x) }

    /// Two-argument arc tangent
    @inlinable
    public func atan2(_ y: Float16, _ x: Float16) -> Float16 { Float16._atan2(y, x) }
}

// MARK: - Hyperbolic Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Hyperbolic sine
    @inlinable
    public func sinh(_ x: Float16) -> Float16 { Float16._sinh(x) }

    /// Hyperbolic cosine
    @inlinable
    public func cosh(_ x: Float16) -> Float16 { Float16._cosh(x) }

    /// Hyperbolic tangent
    @inlinable
    public func tanh(_ x: Float16) -> Float16 { Float16._tanh(x) }
}

// MARK: - Inverse Hyperbolic Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Inverse hyperbolic sine
    @inlinable
    public func asinh(_ x: Float16) -> Float16 { Float16._asinh(x) }

    /// Inverse hyperbolic cosine
    @inlinable
    public func acosh(_ x: Float16) -> Float16 { Float16._acosh(x) }

    /// Inverse hyperbolic tangent
    @inlinable
    public func atanh(_ x: Float16) -> Float16 { Float16._atanh(x) }
}

// MARK: - Special Functions

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
extension Numeric.Math.Accessor where T == Float16 {
    /// Error function
    @inlinable
    public func erf(_ x: Float16) -> Float16 { Float16._erf(x) }

    /// Complementary error function
    @inlinable
    public func erfc(_ x: Float16) -> Float16 { Float16._erfc(x) }

    /// Gamma function
    @inlinable
    public func tgamma(_ x: Float16) -> Float16 { Float16._tgamma(x) }

    #if !os(Windows)
    /// Logarithm of the absolute value of gamma function.
    @inlinable
    public func logGamma(_ x: Float16) -> Float16 { Float16._logGamma(x) }

    /// Sign of gamma function.
    @inlinable
    public func signGamma(_ x: Float16) -> FloatingPointSign { Float16._signGamma(x) }
    #endif
}

#endif
