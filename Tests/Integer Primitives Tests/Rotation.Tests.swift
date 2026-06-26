// Rotation.Tests.swift

import Testing

@testable import Integer_Primitives

// MARK: - Numeric.Integer.Rotation Tests (Parallel Namespace per [TEST-004])

@Suite("Numeric.Integer.Rotation")
struct NumericIntegerRotationTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericIntegerRotationTests.Unit {
    @Test
    func `rotate right by 2`() {
        let value: UInt8 = 0b1100_0011
        let rotated = value.rotation.right(by: 2)
        #expect(rotated == 0b1111_0000)
    }

    @Test
    func `rotate left by 2`() {
        let value: UInt8 = 0b1100_0011
        let rotated = value.rotation.left(by: 2)
        #expect(rotated == 0b0000_1111)
    }

    @Test
    func `rotate right then left returns original`() {
        let value: UInt32 = 0xDEAD_BEEF
        let rotated = value.rotation.right(by: 7).rotation.left(by: 7)
        #expect(rotated == value)
    }
}

// MARK: - Edge Case Tests

extension NumericIntegerRotationTests.EdgeCase {
    @Test
    func `rotate by zero returns original`() {
        let value: UInt8 = 0b1100_0011
        #expect(value.rotation.right(by: 0) == value)
        #expect(value.rotation.left(by: 0) == value)
    }

    @Test
    func `rotate by bit width returns original`() {
        let value: UInt8 = 0b1100_0011
        #expect(value.rotation.right(by: 8) == value)
        #expect(value.rotation.left(by: 8) == value)
    }
}

// MARK: - Numeric.Integer.Saturating Tests (Parallel Namespace per [TEST-004])

@Suite("Numeric.Integer.Saturating")
struct NumericIntegerSaturatingTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericIntegerSaturatingTests.Unit {
    @Test
    func `saturating add within bounds`() {
        #expect(Int8(100).saturating.add(10) == 110)
    }

    @Test
    func `saturating subtract within bounds`() {
        #expect(Int8(-100).saturating.subtract(10) == -110)
    }

    @Test
    func `saturating multiply within bounds`() {
        #expect(Int8(10).saturating.multiply(by: 5) == 50)
    }

    @Test
    func `saturating negate within bounds`() {
        #expect(Int8(-50).saturating.negate() == 50)
    }
}

// MARK: - Edge Case Tests

extension NumericIntegerSaturatingTests.EdgeCase {
    @Test
    func `saturating add clamps at max`() {
        #expect(Int8.max.saturating.add(10) == Int8.max)
    }

    @Test
    func `saturating subtract clamps at min`() {
        #expect(Int8.min.saturating.subtract(10) == Int8.min)
    }

    @Test
    func `saturating multiply clamps at boundaries`() {
        #expect(Int8(100).saturating.multiply(by: 10) == Int8.max)
        #expect(Int8(-100).saturating.multiply(by: 10) == Int8.min)
    }

    @Test
    func `saturating negate of min clamps at max`() {
        #expect(Int8.min.saturating.negate() == Int8.max)
    }
}
