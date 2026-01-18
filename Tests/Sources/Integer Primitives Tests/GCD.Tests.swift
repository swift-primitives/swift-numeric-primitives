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
struct GCDTests {

    @Test
    func basicGCD() {
        #expect(Numeric.Integer.gcd(24, 36) == 12)
        #expect(Numeric.Integer.gcd(17, 13) == 1)
        #expect(Numeric.Integer.gcd(100, 25) == 25)
    }

    @Test
    func gcdWithZero() {
        #expect(Numeric.Integer.gcd(0, 5) == 5)
        #expect(Numeric.Integer.gcd(5, 0) == 5)
        #expect(Numeric.Integer.gcd(0, 0) == 0)
    }

    @Test
    func gcdWithNegative() {
        #expect(Numeric.Integer.gcd(-24, 36) == 12)
        #expect(Numeric.Integer.gcd(24, -36) == 12)
        #expect(Numeric.Integer.gcd(-24, -36) == 12)
    }

    @Test
    func basicLCM() {
        #expect(Numeric.Integer.lcm(4, 6) == 12)
        #expect(Numeric.Integer.lcm(3, 5) == 15)
        #expect(Numeric.Integer.lcm(12, 18) == 36)
    }

    @Test
    func lcmWithZero() {
        #expect(Numeric.Integer.lcm(0, 5) == 0)
        #expect(Numeric.Integer.lcm(5, 0) == 0)
    }

    @Test
    func lcmWithNegative() {
        #expect(Numeric.Integer.lcm(-4, 6) == 12)
        #expect(Numeric.Integer.lcm(4, -6) == 12)
    }
}
