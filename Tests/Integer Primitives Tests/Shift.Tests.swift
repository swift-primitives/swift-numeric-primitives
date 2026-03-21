// Shift.Tests.swift

import Integer_Primitives
import Testing

// MARK: - Test Suite Declaration (Parallel Namespace per [TEST-004])

@Suite("Numeric.Integer.Shift")
struct NumericIntegerShiftTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericIntegerShiftTests.Unit {
    @Test
    func `shift down matches standard right shift operator`() {
        #expect(7.shifted.right(by: 1) == 7 >> 1)
        #expect(7.shifted.right(by: 2) == 7 >> 2)
        #expect((-7).shifted.right(by: 1) == -7 >> 1)
        #expect((-7).shifted.right(by: 2) == -7 >> 2)
    }

    @Test
    func `shift by zero returns original value`() {
        #expect(42.shifted.right(by: 0) == 42)
        #expect((-42).shifted.right(by: 0) == -42)
    }

    @Test
    func `negative shift count means left shift`() {
        #expect(3.shifted.right(by: -1) == 6)
        #expect(3.shifted.right(by: -2) == 12)
    }

    @Test
    func `round down floors toward negative infinity`() {
        #expect(3.shifted.right(by: 1, rounding: .down) == 1)   // 3/2 = 1.5 → 1
        #expect(7.shifted.right(by: 2, rounding: .down) == 1)   // 7/4 = 1.75 → 1
        #expect((-3).shifted.right(by: 1, rounding: .down) == -2) // -3/2 = -1.5 → -2
    }

    @Test
    func `round up ceils toward positive infinity`() {
        #expect(3.shifted.right(by: 1, rounding: .up) == 2)     // 3/2 = 1.5 → 2
        #expect(7.shifted.right(by: 2, rounding: .up) == 2)     // 7/4 = 1.75 → 2
        #expect((-3).shifted.right(by: 1, rounding: .up) == -1) // -3/2 = -1.5 → -1
    }

    @Test
    func `round toward zero truncates`() {
        #expect(3.shifted.right(by: 1, rounding: .zero) == 1)   // 3/2 = 1.5 → 1
        #expect((-3).shifted.right(by: 1, rounding: .zero) == -1) // -3/2 = -1.5 → -1
    }

    @Test
    func `round away from zero`() {
        #expect(3.shifted.right(by: 1, rounding: .away) == 2)   // 3/2 = 1.5 → 2
        #expect((-3).shifted.right(by: 1, rounding: .away) == -2) // -3/2 = -1.5 → -2
    }

    @Test
    func `nearest or even rounds ties to even`() {
        #expect(3.shifted.right(by: 1, rounding: .even) == 2)   // 3/2 = 1.5 → 2 (even)
        #expect(5.shifted.right(by: 1, rounding: .even) == 2)   // 5/2 = 2.5 → 2 (even)
        #expect(7.shifted.right(by: 1, rounding: .even) == 4)   // 7/2 = 3.5 → 4 (even)
    }

    @Test
    func `nearest or up rounds ties up`() {
        #expect(3.shifted.right(by: 1, rounding: .nearest(.up)) == 2) // 3/2 = 1.5 → 2
        #expect(5.shifted.right(by: 1, rounding: .nearest(.up)) == 3) // 5/2 = 2.5 → 3
    }

    @Test
    func `nearest or down rounds ties down`() {
        #expect(3.shifted.right(by: 1, rounding: .nearest(.down)) == 1) // 3/2 = 1.5 → 1
        #expect(5.shifted.right(by: 1, rounding: .nearest(.down)) == 2) // 5/2 = 2.5 → 2
    }

    @Test
    func `nearest or away rounds ties away from zero`() {
        #expect(3.shifted.right(by: 1, rounding: .nearest(.away)) == 2)   // 3/2 = 1.5 → 2
        #expect((-3).shifted.right(by: 1, rounding: .nearest(.away)) == -2) // -3/2 = -1.5 → -2
    }

    @Test
    func `nearest or zero rounds ties toward zero`() {
        #expect(3.shifted.right(by: 1, rounding: .nearest(.zero)) == 1)   // 3/2 = 1.5 → 1
        #expect((-3).shifted.right(by: 1, rounding: .nearest(.zero)) == -1) // -3/2 = -1.5 → -1
    }

    @Test
    func `non-tie values round to nearest`() {
        #expect(7.shifted.right(by: 2, rounding: .even) == 2)         // 7/4 = 1.75 → 2
        #expect(7.shifted.right(by: 2, rounding: .nearest(.up)) == 2)
        #expect(7.shifted.right(by: 2, rounding: .nearest(.down)) == 2)
    }

    @Test
    func `round to odd`() {
        #expect(4.shifted.right(by: 1, rounding: .odd) == 2)  // 4/2 = 2 (exact)
        #expect(3.shifted.right(by: 1, rounding: .odd) == 1)  // 3/2 = 1.5 → 1 (odd)
        #expect(6.shifted.right(by: 1, rounding: .odd) == 3)  // 6/2 = 3 (exact)
        #expect(5.shifted.right(by: 1, rounding: .odd) == 3)  // 5/2 = 2.5 → 3 (odd)
    }

    @Test
    func `exact shift requires no rounding`() {
        #expect(4.shifted.right(by: 2, rounding: .exact) == 1)  // 4/4 = 1 (exact)
        #expect(8.shifted.right(by: 1, rounding: .exact) == 4)  // 8/2 = 4 (exact)
    }
}

// MARK: - Edge Case Tests

extension NumericIntegerShiftTests.EdgeCase {
    @Test
    func `large shift count`() {
        let value: Int8 = 127
        #expect(value.shifted.right(by: 100, rounding: .down) == 0)
        #expect(value.shifted.right(by: 100, rounding: .up) == 1)
    }

    @Test
    func `unsigned integers`() {
        let value: UInt8 = 7
        #expect(value.shifted.right(by: 1, rounding: .down) == 3)
        #expect(value.shifted.right(by: 1, rounding: .up) == 4)
    }

    @Test
    func `generic count types`() {
        let value = 7
        let countInt8: Int8 = 1
        let countUInt: UInt = 1
        #expect(value.shifted.right(by: countInt8) == 3)
        #expect(value.shifted.right(by: countUInt) == 3)
    }
}

// MARK: - Numeric.Rounding Tests (Parallel Namespace per [TEST-004])

@Suite("Numeric.Rounding")
struct NumericRoundingTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension NumericRoundingTests.Unit {
    @Test
    func `directed rounding modes`() {
        #expect(2.5.rounding(.down) == 2.0)
        #expect(2.5.rounding(.up) == 3.0)
        #expect(2.5.rounding(.zero) == 2.0)
        #expect(2.5.rounding(.away) == 3.0)
    }

    @Test
    func `nearest rounding ties to even`() {
        #expect(2.5.rounding(.even) == 2.0)
        #expect(3.5.rounding(.even) == 4.0)
    }

    @Test
    func `nearest rounding with tie breakers`() {
        #expect(2.5.rounding(.nearest(.up)) == 3.0)
        #expect(2.5.rounding(.nearest(.down)) == 2.0)
        #expect(2.5.rounding(.nearest(.away)) == 3.0)
        #expect(2.5.rounding(.nearest(.zero)) == 2.0)
    }

    @Test
    func `odd rounding`() {
        #expect(2.0.rounding(.odd) == 2.0)  // exact, no change
        #expect(2.5.rounding(.odd) == 3.0)  // rounds to odd
        #expect(3.5.rounding(.odd) == 3.0)  // rounds to odd
    }

    @Test
    func `exact rounding for integers`() {
        #expect(2.0.rounding(.exact) == 2.0)
        #expect((-3.0).rounding(.exact) == -3.0)
    }
}

extension NumericRoundingTests.EdgeCase {
    @Test
    func `negative values with directed rounding`() {
        #expect((-2.5).rounding(.down) == -3.0)
        #expect((-2.5).rounding(.up) == -2.0)
        #expect((-2.5).rounding(.zero) == -2.0)
        #expect((-2.5).rounding(.away) == -3.0)
    }

    @Test
    func `non-tie values round to nearest`() {
        #expect(2.3.rounding(.even) == 2.0)
        #expect(2.3.rounding(.nearest(.up)) == 2.0)
        #expect(2.3.rounding(.nearest(.down)) == 2.0)

        #expect(2.7.rounding(.even) == 3.0)
        #expect(2.7.rounding(.nearest(.up)) == 3.0)
        #expect(2.7.rounding(.nearest(.down)) == 3.0)
    }
}
