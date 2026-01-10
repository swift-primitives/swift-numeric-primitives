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

extension Numeric.Math {
    /// Zero-sized accessor token for elementary math operations.
    ///
    /// Methods are specialized per conforming type via constrained extensions.
    /// This pattern provides:
    /// - Zero runtime cost (empty struct)
    /// - No associated types (simpler generics)
    /// - Type-safe dispatch
    ///
    /// Usage:
    /// ```swift
    /// Double.math.exp(x)           // e^x
    /// Float.math.log(onePlus: x)   // log(1+x)
    /// ```
    public struct Accessor<T>: Sendable {
        @usableFromInline
        internal init() {}
    }
}

// MARK: - Generic Methods (for generic code)

extension Numeric.Math.Accessor where T: Numeric.Elementary {
    // Exponential Functions

    @inlinable
    public func exp(_ x: T) -> T { T._exp(x) }

    @inlinable
    public func exp(minusOne x: T) -> T { T._expm1(x) }

    @inlinable
    public func exp2(_ x: T) -> T { T._exp2(x) }

    // Logarithmic Functions

    @inlinable
    public func log(_ x: T) -> T { T._log(x) }

    @inlinable
    public func log(onePlus x: T) -> T { T._log1p(x) }

    @inlinable
    public func log2(_ x: T) -> T { T._log2(x) }

    @inlinable
    public func log10(_ x: T) -> T { T._log10(x) }

    // Power Functions

    @inlinable
    public func pow(_ x: T, _ y: T) -> T { T._pow(x, y) }

    @inlinable
    public func sqrt(_ x: T) -> T { T._sqrt(x) }

    @inlinable
    public func cbrt(_ x: T) -> T { T._cbrt(x) }

    @inlinable
    public func hypot(_ x: T, _ y: T) -> T { T._hypot(x, y) }

    // Trigonometric Functions

    @inlinable
    public func sin(_ x: T) -> T { T._sin(x) }

    @inlinable
    public func cos(_ x: T) -> T { T._cos(x) }

    @inlinable
    public func tan(_ x: T) -> T { T._tan(x) }

    @inlinable
    public func cos(minusOne x: T) -> T {
        let halfX = x / 2
        let sinHalf = T._sin(halfX)
        return -2 * sinHalf * sinHalf
    }

    // Inverse Trigonometric Functions

    @inlinable
    public func asin(_ x: T) -> T { T._asin(x) }

    @inlinable
    public func acos(_ x: T) -> T { T._acos(x) }

    @inlinable
    public func atan(_ x: T) -> T { T._atan(x) }

    @inlinable
    public func atan2(_ y: T, _ x: T) -> T { T._atan2(y, x) }

    // Hyperbolic Functions

    @inlinable
    public func sinh(_ x: T) -> T { T._sinh(x) }

    @inlinable
    public func cosh(_ x: T) -> T { T._cosh(x) }

    @inlinable
    public func tanh(_ x: T) -> T { T._tanh(x) }

    // Inverse Hyperbolic Functions

    @inlinable
    public func asinh(_ x: T) -> T { T._asinh(x) }

    @inlinable
    public func acosh(_ x: T) -> T { T._acosh(x) }

    @inlinable
    public func atanh(_ x: T) -> T { T._atanh(x) }

    // Special Functions

    @inlinable
    public func erf(_ x: T) -> T { T._erf(x) }

    @inlinable
    public func erfc(_ x: T) -> T { T._erfc(x) }

    @inlinable
    public func tgamma(_ x: T) -> T { T._tgamma(x) }
}
