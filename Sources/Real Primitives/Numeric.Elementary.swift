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

extension Numeric {
    /// A type that provides elementary mathematical functions.
    ///
    /// Elementary functions include exponentials, logarithms, trigonometric
    /// functions, and their inverses. Access operations via the `math` accessor:
    ///
    /// ```swift
    /// let y = Double.math.exp(1.0)     // e
    /// let z = Float.math.sin(.pi / 4)  // √2/2
    /// ```
    ///
    /// This protocol uses a zero-sized token pattern: the `math` property
    /// returns a token type that provides type-specialized methods.
    /// This avoids associated types while enabling full inlining.
    public protocol Elementary: FloatingPoint {
        /// Zero-sized token providing math operations.
        static var math: Numeric.Math.Accessor<Self> { get }

        // MARK: - Implementation Requirements

        // These underscored static methods enable generic dispatch.
        // Use `T.math.*` in application code, not these directly.

        static func _exp(_ x: Self) -> Self
        static func _expm1(_ x: Self) -> Self
        static func _exp2(_ x: Self) -> Self
        static func _log(_ x: Self) -> Self
        static func _log1p(_ x: Self) -> Self
        static func _log2(_ x: Self) -> Self
        static func _log10(_ x: Self) -> Self
        static func _pow(_ x: Self, _ y: Self) -> Self
        static func _sqrt(_ x: Self) -> Self
        static func _cbrt(_ x: Self) -> Self
        static func _root(_ x: Self, _ n: Int) -> Self
        static func _hypot(_ x: Self, _ y: Self) -> Self
        static func _sin(_ x: Self) -> Self
        static func _cos(_ x: Self) -> Self
        static func _tan(_ x: Self) -> Self
        static func _asin(_ x: Self) -> Self
        static func _acos(_ x: Self) -> Self
        static func _atan(_ x: Self) -> Self
        static func _atan2(_ y: Self, _ x: Self) -> Self
        static func _sinh(_ x: Self) -> Self
        static func _cosh(_ x: Self) -> Self
        static func _tanh(_ x: Self) -> Self
        static func _asinh(_ x: Self) -> Self
        static func _acosh(_ x: Self) -> Self
        static func _atanh(_ x: Self) -> Self
        static func _erf(_ x: Self) -> Self
        static func _erfc(_ x: Self) -> Self
        static func _tgamma(_ x: Self) -> Self

        #if !os(Windows)
        /// Log of absolute value of gamma function (not available on Windows).
        static func _logGamma(_ x: Self) -> Self

        /// Sign of gamma function (not available on Windows).
        static func _signGamma(_ x: Self) -> FloatingPointSign
        #endif

        // MARK: - Relaxed Arithmetic

        /// `a + b` with optimizer permitted to reassociate and form FMAs.
        static func _relaxedAdd(_ a: Self, _ b: Self) -> Self

        /// `a * b` with optimizer permitted to reassociate and form FMAs.
        static func _relaxedMul(_ a: Self, _ b: Self) -> Self
    }
}

// MARK: - Default Implementation

extension Numeric.Elementary {
    @inlinable
    public static var math: Numeric.Math.Accessor<Self> {
        Numeric.Math.Accessor()
    }

    // Default relaxed arithmetic falls back to strict operations.
    // Conforming types can override with platform-specific intrinsics.

    @inlinable
    public static func _relaxedAdd(_ a: Self, _ b: Self) -> Self {
        a + b
    }

    @inlinable
    public static func _relaxedMul(_ a: Self, _ b: Self) -> Self {
        a * b
    }

    #if !os(Windows)
    /// Default implementation of signGamma.
    ///
    /// For x >= 0, gamma is positive. For negative x at integer values (poles),
    /// we arbitrarily assign positive. Otherwise, sign alternates based on
    /// whether the integral part is even or odd.
    @inlinable
    public static func _signGamma(_ x: Self) -> FloatingPointSign {
        // Gamma is strictly positive for x >= 0
        if x >= 0 { return .plus }
        // For negative integers (poles), arbitrarily assign positive
        let trunc = x.rounded(.towardZero)
        if x == trunc { return .plus }
        // Otherwise, sign is minus if the integral part is even
        // For binary types, x/2 is exact, so check if it's an integer
        let half = trunc / 2
        let isEven = half == half.rounded(.towardZero)
        return isEven ? .minus : .plus
    }
    #endif
}
