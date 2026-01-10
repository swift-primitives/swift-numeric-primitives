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

import Integer_Primitives
import Numeric_Primitives
import Testing

@Suite
struct ShiftTests {

    // MARK: - Basic Shift Tests

    @Suite
    struct BasicTests {

        @Test
        func shiftDownMatchesStandardOperator() {
            // Default rounding (.down) should match >>
            #expect(7.shifted.right(by: 1) == 7 >> 1)
            #expect(7.shifted.right(by: 2) == 7 >> 2)
            #expect((-7).shifted.right(by: 1) == -7 >> 1)
            #expect((-7).shifted.right(by: 2) == -7 >> 2)
        }

        @Test
        func shiftByZero() {
            #expect(42.shifted.right(by: 0) == 42)
            #expect((-42).shifted.right(by: 0) == -42)
        }

        @Test
        func shiftByNegative() {
            // Negative count means left shift
            #expect(3.shifted.right(by: -1) == 6)
            #expect(3.shifted.right(by: -2) == 12)
        }
    }

    // MARK: - Directed Rounding Tests

    @Suite
    struct DirectedRoundingTests {

        @Test
        func roundDown() {
            // 3/2 = 1.5 → 1
            #expect(3.shifted.right(by: 1, rounding: .down) == 1)
            // 7/4 = 1.75 → 1
            #expect(7.shifted.right(by: 2, rounding: .down) == 1)
            // -3/2 = -1.5 → -2
            #expect((-3).shifted.right(by: 1, rounding: .down) == -2)
        }

        @Test
        func roundUp() {
            // 3/2 = 1.5 → 2
            #expect(3.shifted.right(by: 1, rounding: .up) == 2)
            // 7/4 = 1.75 → 2
            #expect(7.shifted.right(by: 2, rounding: .up) == 2)
            // -3/2 = -1.5 → -1
            #expect((-3).shifted.right(by: 1, rounding: .up) == -1)
        }

        @Test
        func roundTowardZero() {
            // 3/2 = 1.5 → 1 (truncate)
            #expect(3.shifted.right(by: 1, rounding: .zero) == 1)
            // -3/2 = -1.5 → -1 (truncate toward zero)
            #expect((-3).shifted.right(by: 1, rounding: .zero) == -1)
        }

        @Test
        func roundAwayFromZero() {
            // 3/2 = 1.5 → 2
            #expect(3.shifted.right(by: 1, rounding: .away) == 2)
            // -3/2 = -1.5 → -2
            #expect((-3).shifted.right(by: 1, rounding: .away) == -2)
        }
    }

    // MARK: - Nearest Rounding Tests

    @Suite
    struct NearestRoundingTests {

        @Test
        func toNearestOrEven() {
            // 3/2 = 1.5, ties go to even → 2
            #expect(3.shifted.right(by: 1, rounding: .even) == 2)
            // 5/2 = 2.5, ties go to even → 2
            #expect(5.shifted.right(by: 1, rounding: .even) == 2)
            // 7/2 = 3.5, ties go to even → 4
            #expect(7.shifted.right(by: 1, rounding: .even) == 4)
        }

        @Test
        func toNearestOrUp() {
            // 3/2 = 1.5, tie goes up → 2
            #expect(3.shifted.right(by: 1, rounding: .nearest(.up)) == 2)
            // 5/2 = 2.5, tie goes up → 3
            #expect(5.shifted.right(by: 1, rounding: .nearest(.up)) == 3)
        }

        @Test
        func toNearestOrDown() {
            // 3/2 = 1.5, tie goes down → 1
            #expect(3.shifted.right(by: 1, rounding: .nearest(.down)) == 1)
            // 5/2 = 2.5, tie goes down → 2
            #expect(5.shifted.right(by: 1, rounding: .nearest(.down)) == 2)
        }

        @Test
        func toNearestOrAway() {
            // 3/2 = 1.5, tie goes away from zero → 2
            #expect(3.shifted.right(by: 1, rounding: .nearest(.away)) == 2)
            // -3/2 = -1.5, tie goes away from zero → -2
            #expect((-3).shifted.right(by: 1, rounding: .nearest(.away)) == -2)
        }

        @Test
        func toNearestOrZero() {
            // 3/2 = 1.5, tie goes toward zero → 1
            #expect(3.shifted.right(by: 1, rounding: .nearest(.zero)) == 1)
            // -3/2 = -1.5, tie goes toward zero → -1
            #expect((-3).shifted.right(by: 1, rounding: .nearest(.zero)) == -1)
        }

        @Test
        func notATie() {
            // 7/4 = 1.75, closer to 2
            #expect(7.shifted.right(by: 2, rounding: .even) == 2)
            #expect(7.shifted.right(by: 2, rounding: .nearest(.up)) == 2)
            #expect(7.shifted.right(by: 2, rounding: .nearest(.down)) == 2)
        }
    }

    // MARK: - Special Rounding Tests

    @Suite
    struct SpecialRoundingTests {

        @Test
        func toOdd() {
            // 4/2 = 2 (exact), stays 2
            #expect(4.shifted.right(by: 1, rounding: .odd) == 2)
            // 3/2 = 1.5, rounds to odd → 1
            #expect(3.shifted.right(by: 1, rounding: .odd) == 1)
            // 6/2 = 3 (exact), stays 3
            #expect(6.shifted.right(by: 1, rounding: .odd) == 3)
            // 5/2 = 2.5, rounds to odd → 3
            #expect(5.shifted.right(by: 1, rounding: .odd) == 3)
        }

        @Test
        func exactShift() {
            // 4/4 = 1 (exact), no trap
            #expect(4.shifted.right(by: 2, rounding: .exact) == 1)
            // 8/2 = 4 (exact), no trap
            #expect(8.shifted.right(by: 1, rounding: .exact) == 4)
        }
    }

    // MARK: - Edge Cases

    @Suite
    struct EdgeCases {

        @Test
        func largeShiftCount() {
            // Shifting by more than bitWidth
            let value: Int8 = 127
            #expect(value.shifted.right(by: 100, rounding: .down) == 0)
            #expect(value.shifted.right(by: 100, rounding: .up) == 1)
        }

        @Test
        func unsignedIntegers() {
            let value: UInt8 = 7
            #expect(value.shifted.right(by: 1, rounding: .down) == 3)
            #expect(value.shifted.right(by: 1, rounding: .up) == 4)
        }

        @Test
        func genericCount() {
            // Test with different BinaryInteger count types
            let value = 7
            let countInt8: Int8 = 1
            let countUInt: UInt = 1
            #expect(value.shifted.right(by: countInt8) == 3)
            #expect(value.shifted.right(by: countUInt) == 3)
        }
    }
}

// MARK: - FloatingPoint Rounding Tests

@Suite
struct FloatingPointRoundingTests {

    @Test
    func directedRounding() {
        #expect(2.5.rounding(.down) == 2.0)
        #expect(2.5.rounding(.up) == 3.0)
        #expect(2.5.rounding(.zero) == 2.0)
        #expect(2.5.rounding(.away) == 3.0)

        #expect((-2.5).rounding(.down) == -3.0)
        #expect((-2.5).rounding(.up) == -2.0)
        #expect((-2.5).rounding(.zero) == -2.0)
        #expect((-2.5).rounding(.away) == -3.0)
    }

    @Test
    func nearestRounding() {
        // 2.5 - ties
        #expect(2.5.rounding(.even) == 2.0)
        #expect(2.5.rounding(.nearest(.up)) == 3.0)
        #expect(2.5.rounding(.nearest(.down)) == 2.0)
        #expect(2.5.rounding(.nearest(.away)) == 3.0)
        #expect(2.5.rounding(.nearest(.zero)) == 2.0)

        // 3.5 - ties
        #expect(3.5.rounding(.even) == 4.0)
        #expect(3.5.rounding(.nearest(.up)) == 4.0)
        #expect(3.5.rounding(.nearest(.down)) == 3.0)
    }

    @Test
    func oddRounding() {
        #expect(2.0.rounding(.odd) == 2.0)  // exact, no change
        #expect(2.5.rounding(.odd) == 3.0)  // rounds to odd
        #expect(3.5.rounding(.odd) == 3.0)  // rounds to odd
    }

    @Test
    func exactRounding() {
        #expect(2.0.rounding(.exact) == 2.0)  // exact integer, no trap
        #expect((-3.0).rounding(.exact) == -3.0)
    }

    @Test
    func notATie() {
        // 2.3 is closer to 2
        #expect(2.3.rounding(.even) == 2.0)
        #expect(2.3.rounding(.nearest(.up)) == 2.0)
        #expect(2.3.rounding(.nearest(.down)) == 2.0)

        // 2.7 is closer to 3
        #expect(2.7.rounding(.even) == 3.0)
        #expect(2.7.rounding(.nearest(.up)) == 3.0)
        #expect(2.7.rounding(.nearest(.down)) == 3.0)
    }
}
