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
    /// A compile-time fraction with integer generic parameters (SE-0452).
    ///
    /// `Fraction` stores a pre-computed value based on compile-time numerator
    /// and denominator. Use `callAsFunction()` or the `value` property to
    /// retrieve the result.
    ///
    /// ```swift
    /// let third = Radian<Double>.pi.fraction<1, 3>()()  // π/3
    /// let half = Degree<Double>.right.fraction<1, 2>()()  // 45°
    /// ```
    public struct Fraction<let Numerator: Int, let Denominator: Int, Result> {
        /// The computed value of this fraction.
        public let value: Result

        /// Creates a fraction wrapping a pre-computed value.
        @inlinable
        public init(_ value: Result) {
            self.value = value
        }

        /// Returns the computed value of this fraction.
        @inlinable
        public func callAsFunction() -> Result { value }
    }
}

extension Numeric.Fraction: Sendable where Result: Sendable {}
