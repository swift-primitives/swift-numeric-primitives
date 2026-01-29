// Division.Tests.swift

import Testing
@testable import Integer_Primitives

// MARK: - Test Suite Declaration (Parallel Namespace per [TEST-004])

@Suite("Numeric.Integer.Division")
struct NumericIntegerDivisionTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericIntegerDivisionTests.Unit {
    @Test
    func `floor division of positive values`() {
        #expect(17.division(by: 5) == 3)
        #expect(15.division(by: 5) == 3)
    }

    @Test
    func `ceiling division of positive values`() {
        #expect(17.division(by: 5, rounding: .up) == 4)
        #expect(15.division(by: 5, rounding: .up) == 3)
    }

    @Test
    func `truncating division rounds toward zero`() {
        #expect(17.division(by: 5, rounding: .zero) == 3)
        #expect((-17).division(by: 5, rounding: .zero) == -3)
    }

    @Test
    func `division parts satisfy quotient times divisor plus remainder equals dividend`() {
        let (q, r) = 17.division.parts(by: 5)
        #expect(q == 3)
        #expect(r == 2)
        #expect(q * 5 + r == 17)
    }

    @Test
    func `bankers rounding ties to even`() {
        #expect(15.division(by: 10, rounding: .even) == 2)  // 1.5 → 2 (even)
        #expect(25.division(by: 10, rounding: .even) == 2)  // 2.5 → 2 (even)
        #expect(35.division(by: 10, rounding: .even) == 4)  // 3.5 → 4 (even)
    }
}

// MARK: - Edge Case Tests

extension NumericIntegerDivisionTests.EdgeCase {
    @Test
    func `floor division rounds toward negative infinity`() {
        #expect((-17).division(by: 5) == -4)
        #expect(17.division(by: -5) == -4)
        #expect((-17).division(by: -5) == 3)
    }

    @Test
    func `ceiling division rounds toward positive infinity`() {
        #expect((-17).division(by: 5, rounding: .up) == -3)
    }

    @Test
    func `division parts with negative dividend`() {
        let (q, r) = (-17).division.parts(by: 5)
        #expect(q == -4)
        #expect(r == 3)
        #expect(q * 5 + r == -17)
    }
}
