// GCD.Tests.swift

import Testing

@testable import Integer_Primitives

// MARK: - Test Suite Declaration (Parallel Namespace per [TEST-004])

@Suite("Numeric.Integer.gcd")
struct NumericIntegerGCDTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericIntegerGCDTests.Unit {
    @Test
    func `GCD of 24 and 36 equals 12`() {
        #expect(Numeric.Integer.gcd(24, 36) == 12)
    }

    @Test
    func `GCD of coprime numbers equals 1`() {
        #expect(Numeric.Integer.gcd(17, 13) == 1)
    }

    @Test
    func `GCD when one divides the other`() {
        #expect(Numeric.Integer.gcd(100, 25) == 25)
    }

    @Test
    func `LCM of 4 and 6 equals 12`() {
        #expect(Numeric.Integer.lcm(4, 6) == 12)
    }

    @Test
    func `LCM of coprime numbers equals product`() {
        #expect(Numeric.Integer.lcm(3, 5) == 15)
    }

    @Test
    func `LCM of 12 and 18 equals 36`() {
        #expect(Numeric.Integer.lcm(12, 18) == 36)
    }
}

// MARK: - Edge Case Tests

extension NumericIntegerGCDTests.EdgeCase {
    @Test
    func `GCD with zero returns other value`() {
        #expect(Numeric.Integer.gcd(0, 5) == 5)
        #expect(Numeric.Integer.gcd(5, 0) == 5)
        #expect(Numeric.Integer.gcd(0, 0) == 0)
    }

    @Test
    func `GCD with negative values`() {
        #expect(Numeric.Integer.gcd(-24, 36) == 12)
        #expect(Numeric.Integer.gcd(24, -36) == 12)
        #expect(Numeric.Integer.gcd(-24, -36) == 12)
    }

    @Test
    func `LCM with zero returns zero`() {
        #expect(Numeric.Integer.lcm(0, 5) == 0)
        #expect(Numeric.Integer.lcm(5, 0) == 0)
    }

    @Test
    func `LCM with negative values`() {
        #expect(Numeric.Integer.lcm(-4, 6) == 12)
        #expect(Numeric.Integer.lcm(4, -6) == 12)
    }
}
