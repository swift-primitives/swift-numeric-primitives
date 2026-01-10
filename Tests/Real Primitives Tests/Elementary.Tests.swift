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
@testable import Real_Primitives

@Suite
struct ElementaryTests {

    // MARK: - Exponential Functions

    @Test
    func exp() {
        let result = Double.math.exp(1.0)
        // e ≈ 2.71828...
        #expect(result.approximate.equals(2.718281828459045, tolerance: 1e-10))
    }

    @Test
    func expMinusOne() {
        // exp(0) - 1 = 0
        let result = Double.math.exp(minusOne: 0.0)
        #expect(result.approximate.equals(0.0, tolerance: 1e-15))

        // For small x, exp(x) - 1 ≈ x
        let small = 1e-10
        let resultSmall = Double.math.exp(minusOne: small)
        #expect(resultSmall.approximate.equals(small, tolerance: 1e-15))
    }

    // MARK: - Logarithmic Functions

    @Test
    func log() {
        let e = Double.math.exp(1.0)
        let result = Double.math.log(e)
        #expect(result.approximate.equals(1.0, tolerance: 1e-10))
    }

    @Test
    func logOnePlus() {
        // log(1 + 0) = 0
        let result = Double.math.log(onePlus: 0.0)
        #expect(result.approximate.equals(0.0, tolerance: 1e-15))

        // For small x, log(1 + x) ≈ x
        let small = 1e-10
        let resultSmall = Double.math.log(onePlus: small)
        #expect(resultSmall.approximate.equals(small, tolerance: 1e-15))
    }

    // MARK: - Trigonometric Functions

    @Test
    func sinAndCos() {
        let angle = Double.pi / 4
        let s = Double.math.sin(angle)
        let c = Double.math.cos(angle)

        // sin(π/4) = cos(π/4) = √2/2
        let expected = Double.math.sqrt(2.0) / 2
        #expect(s.approximate.equals(expected, tolerance: 1e-10))
        #expect(c.approximate.equals(expected, tolerance: 1e-10))

        // sin²(x) + cos²(x) = 1
        #expect((s * s + c * c).approximate.equals(1.0, tolerance: 1e-10))
    }

    @Test
    func cosMinusOne() {
        // cos(0) - 1 = 0
        let result = Double.math.cos(minusOne: 0.0)
        #expect(result.approximate.equals(0.0, tolerance: 1e-15))

        // For small x, cos(x) - 1 ≈ -x²/2
        let small = 1e-5
        let resultSmall = Double.math.cos(minusOne: small)
        let expected = -small * small / 2
        #expect(resultSmall.approximate.equals(expected, tolerance: 1e-15))
    }

    @Test
    func atan2() {
        // atan2(1, 1) = π/4
        let result = Double.math.atan2(1.0, 1.0)
        #expect(result.approximate.equals(Double.pi / 4, tolerance: 1e-10))

        // atan2(0, 1) = 0
        let zero = Double.math.atan2(0.0, 1.0)
        #expect(zero.approximate.equals(0.0, tolerance: 1e-15))
    }

    // MARK: - Hyperbolic Functions

    @Test
    func hyperbolic() {
        let x = 1.0
        let s = Double.math.sinh(x)
        let c = Double.math.cosh(x)

        // cosh²(x) - sinh²(x) = 1
        #expect((c * c - s * s).approximate.equals(1.0, tolerance: 1e-10))
    }

    // MARK: - Power Functions

    @Test
    func pow() {
        let result = Double.math.pow(2.0, 3.0)
        #expect(result.approximate.equals(8.0, tolerance: 1e-10))
    }

    @Test
    func sqrt() {
        let result = Double.math.sqrt(4.0)
        #expect(result.approximate.equals(2.0, tolerance: 1e-15))
    }

    @Test
    func hypot() {
        // 3² + 4² = 5²
        let result = Double.math.hypot(3.0, 4.0)
        #expect(result.approximate.equals(5.0, tolerance: 1e-10))
    }
}
