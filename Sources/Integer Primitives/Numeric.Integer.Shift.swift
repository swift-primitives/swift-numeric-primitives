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

import Numeric_Primitives

extension Numeric.Integer {
    /// Accessor for shift operations with rounding.
    ///
    /// Access via the `.shifted` property on integers:
    ///
    /// ```swift
    /// let q = 7.shifted.right(by: 2)                    // 1 (floor)
    /// let r = 7.shifted.right(by: 2, rounding: .up)     // 2 (ceiling)
    /// let s = 3.shifted.right(by: 1, rounding: .even)   // 2 (banker's)
    /// ```
    public struct Shift<T: BinaryInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Shift: Sendable where T: Sendable {
}

// MARK: - Right Shift

extension Numeric.Integer.Shift {
    /// `value` divided by 2^(`count`), rounding the result according to `rule`.
    ///
    /// The default rounding rule is `.down`, which matches the behavior of
    /// the `>>` operator from the standard library.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// // 3/2 is 1.5, which rounds (down by default) to 1.
    /// 3.shifted.right(by: 1)
    ///
    /// // 1.5 rounds up to 2.
    /// 3.shifted.right(by: 1, rounding: .up)
    ///
    /// // Banker's rounding: ties go to even.
    /// 3.shifted.right(by: 1, rounding: .even)
    ///
    /// // 4/4 is exactly 1, so this does not trap.
    /// 4.shifted.right(by: 2, rounding: .exact)
    ///
    /// // 5/2 is 2.5, which is not an integer, so this traps.
    /// 5.shifted.right(by: 1, rounding: .exact)
    /// ```
    ///
    /// When `T(1) << count` is positive, the following are equivalent:
    ///
    /// ```swift
    /// a.shifted.right(by: count, rounding: rule)
    /// a.division(by: 1 << count, rounding: rule)
    /// ```
    @inlinable
    public func right(
        by count: Int,
        rounding rule: Numeric.Rounding = .down
    ) -> T {
        // count is zero or negative: shift is exact
        if count <= 0 { return value >> count }

        if count >= value.bitWidth {
            // Handle pathological case of very small bitWidth
            if value.bitWidth <= 1 {
                return T(Int8(value).shifted.right(by: count, rounding: rule))
            }
            // Over-wide shifts: first shift with sticky rounding, then final shift
            let shiftCount = count - (value.bitWidth - 1)
            let floor = value >> shiftCount
            let lost = value - (floor << shiftCount)
            let sticky = floor | (lost == 0 ? 0 : 1)
            return sticky.shifted.right(by: value.bitWidth - 1, rounding: rule)
        }

        // Happy case: 0 < count < bitWidth
        let mask = T.Magnitude(1) << count - 1
        let lost = T.Magnitude(truncatingIfNeeded: value) & mask
        let floor = value >> count
        let ceiling = floor + (lost == 0 ? 0 : 1)
        let half: T.Magnitude = (1 as T.Magnitude) << (count &- 1)

        switch rule {
        case .direction(.down):
            return floor

        case .direction(.up):
            return ceiling

        case .direction(.zero):
            return value > 0 ? floor : ceiling

        case .direction(.away):
            return value < 0 ? floor : ceiling

        case .nearest(.down):
            return floor + T((lost + (half - 1)) >> count)

        case .nearest(.up):
            return floor + T((lost + half) >> count)

        case .nearest(.zero):
            let round = half - (value < 0 ? 0 : 1)
            return floor + T((round + lost) >> count)

        case .nearest(.away):
            let round = half - (value > 0 ? 0 : 1)
            return floor + T((round + lost) >> count)

        case .nearest(.even):
            let round = mask >> 1 + T.Magnitude(floor & 1)
            return floor + T((round + lost) >> count)

        case .odd:
            return floor | (lost == 0 ? 0 : 1)

        case .exact:
            precondition(lost == 0, "shift was not exact.")
            return floor
        }
    }

    /// `value` divided by 2^(`count`), rounding the result according to `rule`.
    ///
    /// Generic overload that accepts any `BinaryInteger` count.
    @inlinable @inline(__always)
    public func right<Count: BinaryInteger>(
        by count: Count,
        rounding rule: Numeric.Rounding = .down
    ) -> T {
        self.right(by: Int(clamping: count), rounding: rule)
    }
}
