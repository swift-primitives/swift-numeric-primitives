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
struct DivisionTests {

    // MARK: - Floor Division

    @Test
    func floorDivisionPositive() {
        #expect(17.division(by: 5) == 3)
        #expect(15.division(by: 5) == 3)
    }

    @Test
    func floorDivisionNegative() {
        // Floor division rounds toward -∞
        #expect((-17).division(by: 5) == -4)
        #expect(17.division(by: -5) == -4)
        #expect((-17).division(by: -5) == 3)
    }

    // MARK: - Ceiling Division

    @Test
    func ceilingDivisionPositive() {
        #expect(17.division(by: 5, rounding: .up) == 4)
        #expect(15.division(by: 5, rounding: .up) == 3)
    }

    @Test
    func ceilingDivisionNegative() {
        // Ceiling division rounds toward +∞
        #expect((-17).division(by: 5, rounding: .up) == -3)
    }

    // MARK: - Truncating Division

    @Test
    func truncatingDivision() {
        // Truncating rounds toward zero (Swift's default)
        #expect(17.division(by: 5, rounding: .zero) == 3)
        #expect((-17).division(by: 5, rounding: .zero) == -3)
    }

    // MARK: - Division Parts

    @Test
    func divisionParts() {
        let (q, r) = 17.division.parts(by: 5)
        #expect(q == 3)
        #expect(r == 2)
        #expect(q * 5 + r == 17)
    }

    @Test
    func divisionPartsNegative() {
        let (q, r) = (-17).division.parts(by: 5)
        #expect(q == -4)
        #expect(r == 3)
        #expect(q * 5 + r == -17)
    }

    // MARK: - Banker's Rounding

    @Test
    func bankersRounding() {
        // Ties round to even
        #expect(15.division(by: 10, rounding: .even) == 2)  // 1.5 → 2 (even)
        #expect(25.division(by: 10, rounding: .even) == 2)  // 2.5 → 2 (even)
        #expect(35.division(by: 10, rounding: .even) == 4)  // 3.5 → 4 (even)
    }
}
