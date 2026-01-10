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
    /// Double.math.exp.minus.one(x) // e^x - 1
    /// Double.math.log(x)           // ln(x)
    /// Double.math.log.one.plus(x)  // ln(1+x)
    /// ```
    public struct Accessor<T>: Sendable {
        @usableFromInline
        internal init() {}
    }
}

// MARK: - Exp Accessor

extension Numeric.Math {
    /// Accessor for exponential function variants.
    public struct Exp<T: Numeric.Elementary>: Sendable {
        @usableFromInline
        internal init() {}

        /// e^x
        @inlinable
        public func callAsFunction(_ x: T) -> T { T._exp(x) }

        /// Access shifted exponential variants.
        @inlinable
        public var minus: Minus { Minus() }

        /// Accessor for exp(x) - k variants.
        public struct Minus: Sendable {
            @usableFromInline
            internal init() {}

            /// e^x - 1, accurate for small x.
            ///
            /// For small values of x, computing `exp(x) - 1` directly loses
            /// precision due to catastrophic cancellation. This function
            /// computes the result accurately.
            @inlinable
            public func one(_ x: T) -> T { T._expm1(x) }
        }
    }
}

// MARK: - Log Accessor

extension Numeric.Math {
    /// Accessor for logarithm function variants.
    public struct Log<T: Numeric.Elementary>: Sendable {
        @usableFromInline
        internal init() {}

        /// Natural logarithm ln(x).
        @inlinable
        public func callAsFunction(_ x: T) -> T { T._log(x) }

        /// Access log(1+x) variants.
        @inlinable
        public var one: One { One() }

        /// Accessor for log(1 + x) variants.
        public struct One: Sendable {
            @usableFromInline
            internal init() {}

            /// ln(1+x), accurate for small x.
            ///
            /// For small values of x, computing `log(1 + x)` directly loses
            /// precision due to catastrophic cancellation. This function
            /// computes the result accurately.
            @inlinable
            public func plus(_ x: T) -> T { T._log1p(x) }
        }
    }
}

// MARK: - Cos Accessor

extension Numeric.Math {
    /// Accessor for cosine function variants.
    public struct Cos<T: Numeric.Elementary>: Sendable {
        @usableFromInline
        internal init() {}

        /// Cosine of x.
        @inlinable
        public func callAsFunction(_ x: T) -> T { T._cos(x) }

        /// Access shifted cosine variants.
        @inlinable
        public var minus: Minus { Minus() }

        /// Accessor for cos(x) - k variants.
        public struct Minus: Sendable {
            @usableFromInline
            internal init() {}

            /// cos(x) - 1, accurate for small x.
            ///
            /// Uses the identity: cos(x) - 1 = -2 * sin(x/2)²
            @inlinable
            public func one(_ x: T) -> T {
                let halfX = x / 2
                let sinHalf = T._sin(halfX)
                return -2 * sinHalf * sinHalf
            }
        }
    }
}

// MARK: - Generic Methods (for generic code)

extension Numeric.Math.Accessor where T: Numeric.Elementary {
    // Exponential Functions

    /// Access exponential function and variants.
    ///
    /// ```swift
    /// Double.math.exp(x)           // e^x
    /// Double.math.exp.minus.one(x) // e^x - 1
    /// ```
    @inlinable
    public var exp: Numeric.Math.Exp<T> { .init() }

    @inlinable
    public func exp2(_ x: T) -> T { T._exp2(x) }

    // Logarithmic Functions

    /// Access logarithm function and variants.
    ///
    /// ```swift
    /// Double.math.log(x)           // ln(x)
    /// Double.math.log.one.plus(x)  // ln(1+x)
    /// ```
    @inlinable
    public var log: Numeric.Math.Log<T> { .init() }

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

    /// Access cosine function and variants.
    ///
    /// ```swift
    /// Double.math.cos(x)           // cos(x)
    /// Double.math.cos.minus.one(x) // cos(x) - 1
    /// ```
    @inlinable
    public var cos: Numeric.Math.Cos<T> { .init() }

    @inlinable
    public func tan(_ x: T) -> T { T._tan(x) }

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
