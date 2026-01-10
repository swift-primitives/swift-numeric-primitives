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
    /// Specifies the rounding behavior for numeric operations.
    ///
    /// Rounding modes are organized into directed rounding (`.direction`)
    /// and rounding to nearest (`.nearest`), plus special modes.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Convenience accessors for common modes
    /// let q = value.division(by: 3, rounding: .down)    // floor
    /// let r = value.division(by: 3, rounding: .even)    // banker's rounding
    ///
    /// // Explicit nested form
    /// let s = value.division(by: 3, rounding: .direction(.away))
    /// let t = value.division(by: 3, rounding: .nearest(.zero))
    /// ```
    public enum Rounding: Sendable, Equatable {
        /// Directed rounding (always rounds in one direction).
        case direction(Direction)

        /// Rounds to nearest representable value with tie-breaking rule.
        case nearest(Nearest)

        /// Rounds to the nearest odd value (sticky rounding).
        case odd

        /// Requires exact result; traps if rounding would be needed.
        case exact

        /// Directed rounding modes.
        public enum Direction: Sendable, Equatable {
            /// Round toward negative infinity (floor).
            case down

            /// Round toward positive infinity (ceiling).
            case up

            /// Round toward zero (truncate).
            case zero

            /// Round away from zero.
            case away
        }

        /// Tie-breaking rules for rounding to nearest.
        public enum Nearest: Sendable, Equatable {
            /// Ties round toward negative infinity.
            case down

            /// Ties round toward positive infinity.
            case up

            /// Ties round toward zero.
            case zero

            /// Ties round away from zero.
            case away

            /// Ties round to even (banker's rounding).
            case even
        }
    }
}

// MARK: - Convenience Accessors

extension Numeric.Rounding {
    /// Round toward negative infinity (floor).
    @inlinable
    public static var down: Self { .direction(.down) }

    /// Round toward positive infinity (ceiling).
    @inlinable
    public static var up: Self { .direction(.up) }

    /// Round toward zero (truncate).
    @inlinable
    public static var zero: Self { .direction(.zero) }

    /// Ties round to even (banker's rounding).
    @inlinable
    public static var even: Self { .nearest(.even) }
}

// MARK: - Codable

#if !hasFeature(Embedded)
extension Numeric.Rounding: Codable {}
extension Numeric.Rounding.Direction: Codable {}
extension Numeric.Rounding.Nearest: Codable {}
#endif
