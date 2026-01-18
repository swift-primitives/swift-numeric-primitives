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

import Testing
@testable import Integer_Primitives

@Suite
struct RotationTests {

    @Test
    func rotateRight() {
        let value: UInt8 = 0b1100_0011
        let rotated = value.rotation.right(by: 2)
        #expect(rotated == 0b1111_0000)
    }

    @Test
    func rotateLeft() {
        let value: UInt8 = 0b1100_0011
        let rotated = value.rotation.left(by: 2)
        #expect(rotated == 0b0000_1111)
    }

    @Test
    func rotateByZero() {
        let value: UInt8 = 0b1100_0011
        #expect(value.rotation.right(by: 0) == value)
        #expect(value.rotation.left(by: 0) == value)
    }

    @Test
    func rotateByBitWidth() {
        let value: UInt8 = 0b1100_0011
        #expect(value.rotation.right(by: 8) == value)
        #expect(value.rotation.left(by: 8) == value)
    }

    @Test
    func rotateRightThenLeft() {
        let value: UInt32 = 0xDEADBEEF
        let rotated = value.rotation.right(by: 7).rotation.left(by: 7)
        #expect(rotated == value)
    }
}

@Suite
struct SaturatingTests {

    @Test
    func saturatingAdd() {
        #expect(Int8.max.saturating.add(10) == Int8.max)
        #expect(Int8(100).saturating.add(10) == 110)
    }

    @Test
    func saturatingSubtract() {
        #expect(Int8.min.saturating.subtract(10) == Int8.min)
        #expect(Int8(-100).saturating.subtract(10) == -110)
    }

    @Test
    func saturatingMultiply() {
        #expect(Int8(100).saturating.multiply(by: 10) == Int8.max)
        #expect(Int8(-100).saturating.multiply(by: 10) == Int8.min)
        #expect(Int8(10).saturating.multiply(by: 5) == 50)
    }

    @Test
    func saturatingNegate() {
        #expect(Int8.min.saturating.negate() == Int8.max)
        #expect(Int8(-50).saturating.negate() == 50)
    }
}
