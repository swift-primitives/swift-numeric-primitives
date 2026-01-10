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

extension Numeric.Integer {
    /// Accessor struct for integer division operations.
    ///
    /// Access via the `.division` property on signed integers:
    ///
    /// ```swift
    /// let q = 17.division(by: 5)             // quotient only
    /// let (q, r) = 17.division.parts(by: 5)  // quotient and remainder
    /// ```
    public struct Division<T: SignedInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Division: Sendable where T: Sendable {}

// MARK: - Division Operations

extension Numeric.Integer.Division {
    /// Returns the quotient of dividing by the given divisor.
    ///
    /// Uses floor rounding by default (rounds toward negative infinity).
    ///
    /// - Parameters:
    ///   - divisor: The value to divide by.
    ///   - rounding: The rounding mode (default `.down` for floor division).
    /// - Returns: The quotient.
    @inlinable
    public func callAsFunction(by divisor: T, rounding: Numeric.Rounding = .down) -> T {
        switch rounding {
        case .direction(.down):
            // Floor division: rounds toward -∞
            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 && (value < 0) != (divisor < 0) {
                return q - 1
            }
            return q

        case .direction(.up):
            // Ceiling division: rounds toward +∞
            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 && (value < 0) == (divisor < 0) {
                return q + 1
            }
            return q

        case .direction(.zero):
            // Truncating division: rounds toward zero (Swift's default)
            return value / divisor

        case .direction(.away):
            // Rounds away from zero
            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 {
                return q < 0 ? q - 1 : q + 1
            }
            return q

        case .nearest(let tie):
            return divideToNearest(by: divisor, tieBreaker: tie)

        case .odd, .exact:
            // Not commonly used for integers; fallback to truncating
            return value / divisor
        }
    }

    /// Returns both quotient and remainder.
    ///
    /// - Parameters:
    ///   - divisor: The value to divide by.
    ///   - rounding: The rounding mode (default `.down` for floor division).
    /// - Returns: A tuple of (quotient, remainder).
    @inlinable
    public func parts(by divisor: T, rounding: Numeric.Rounding = .down) -> (quotient: T, remainder: T) {
        let q = self.callAsFunction(by: divisor, rounding: rounding)
        let r = value - q * divisor
        return (q, r)
    }

    @usableFromInline
    internal func divideToNearest(by divisor: T, tieBreaker: Numeric.Rounding.Nearest) -> T {
        let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
        let absR = r < 0 ? -r : r
        let absD = divisor < 0 ? -divisor : divisor
        let doubled = absR * 2

        if doubled < absD {
            return q
        } else if doubled > absD {
            return (value < 0) != (divisor < 0) ? q - 1 : q + 1
        } else {
            // Exact tie - apply tie-breaking rule
            switch tieBreaker {
            case .down:
                return (value < 0) != (divisor < 0) ? q - 1 : q
            case .up:
                return (value < 0) == (divisor < 0) ? q + 1 : q
            case .zero:
                return q
            case .away:
                return (value < 0) != (divisor < 0) ? q - 1 : q + 1
            case .even:
                return q % 2 == 0 ? q : ((value < 0) != (divisor < 0) ? q - 1 : q + 1)
            }
        }
    }
}
