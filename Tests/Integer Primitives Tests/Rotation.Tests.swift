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

    // F-001 regression: `>>` on a signed FixedWidthInteger is an arithmetic
    // (sign-extending) shift, not a logical shift. Rotating the bit pattern
    // of a negative value therefore must not use the signed `>>`/`<<`
    // operators directly on `T` — doing so replicates the sign bit into
    // positions that should instead receive the bits that fell off the
    // opposite end, silently corrupting the result (and can even leave a
    // rotated value with the wrong sign).

    @Test
    func `rotate right by 1 on Int8 min is a positive value not sign-extended`() {
        // Int8.min bit pattern 0b1000_0000 rotated right by 1 moves the sign
        // bit into position 6; the vacated MSB receives the bit that fell
        // off the LSB (0). Correct bit pattern: 0b0100_0000 = 64.
        let value = Int8.min
        #expect(value.rotation.right(by: 1) == 64)
    }

    @Test
    func `rotate left by 1 on Int8 min is a positive value not sign-extended`() {
        // Int8.min bit pattern 0b1000_0000 rotated left by 1: the sign bit
        // (1) that falls off the MSB wraps around into the LSB. Correct bit
        // pattern: 0b0000_0001 = 1.
        let value = Int8.min
        #expect(value.rotation.left(by: 1) == 1)
    }

    @Test
    func `rotate right by 1 on Int min is a positive value not sign-extended`() {
        // Int.min bit pattern 0x8000_0000_0000_0000 rotated right by 1:
        // correct bit pattern is 0x4000_0000_0000_0000 == 2^62.
        let value = Int.min
        #expect(value.rotation.right(by: 1) == 4_611_686_018_427_387_904)
    }

    @Test
    func `rotate right by 3 on negative Int16 does not sign extend intermediate bits`() {
        // Int16(-100) bit pattern 0b1111_1111_1001_1100 rotated right by 3.
        // Computed independently against the unsigned bit pattern:
        // 0xFF9C >> 3 == 0x1FF3, wrapped-in top 3 bits (from the LSB) are
        // 0b100, giving 0x9 in the top nibble's low bits: 0x9FF3.
        let value: Int16 = -100
        #expect(value.rotation.right(by: 3) == Int16(bitPattern: 0x9FF3))
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
