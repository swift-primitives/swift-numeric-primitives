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

import Real_Primitives
import Testing

@Suite
struct RelaxedTests {

    // MARK: - Sum Tests

    @Suite
    struct SumTests {

        @Test
        func sumEqualsAddition() {
            // In isolation, relaxed sum must produce the same result as +
            let a = 1.5
            let b = 2.5
            #expect(Numeric.Relaxed.sum(a, b) == a + b)
        }

        @Test
        func sumFloat() {
            let a: Float = 1.5
            let b: Float = 2.5
            #expect(Numeric.Relaxed.sum(a, b) == a + b)
        }

        @Test
        func sumWithNegative() {
            // a - b via relaxed sum
            let a = 10.0
            let b = 3.0
            #expect(Numeric.Relaxed.sum(a, -b) == a - b)
        }

        @Test
        func sumZero() {
            #expect(Numeric.Relaxed.sum(0.0, 0.0) == 0.0)
            #expect(Numeric.Relaxed.sum(5.0, 0.0) == 5.0)
            #expect(Numeric.Relaxed.sum(0.0, 5.0) == 5.0)
        }
    }

    // MARK: - Product Tests

    @Suite
    struct ProductTests {

        @Test
        func productEqualsMultiplication() {
            // In isolation, relaxed product must produce the same result as *
            let a = 2.0
            let b = 3.0
            #expect(Numeric.Relaxed.product(a, b) == a * b)
        }

        @Test
        func productFloat() {
            let a: Float = 2.0
            let b: Float = 3.0
            #expect(Numeric.Relaxed.product(a, b) == a * b)
        }

        @Test
        func productZero() {
            #expect(Numeric.Relaxed.product(0.0, 5.0) == 0.0)
            #expect(Numeric.Relaxed.product(5.0, 0.0) == 0.0)
        }

        @Test
        func productOne() {
            #expect(Numeric.Relaxed.product(1.0, 5.0) == 5.0)
            #expect(Numeric.Relaxed.product(5.0, 1.0) == 5.0)
        }
    }

    // MARK: - MultiplyAdd Tests

    @Suite
    struct MultiplyAddTests {

        @Test
        func multiplyAddBasic() {
            // a * b + c should be either unfused or fused result
            let a = 2.0
            let b = 3.0
            let c = 1.0

            let unfused = a * b + c
            let fused = c.addingProduct(a, b)
            let relaxed = Numeric.Relaxed.multiplyAdd(a, b, c)

            // Result must be one of the two valid computations
            #expect(relaxed == unfused || relaxed == fused)
        }

        @Test
        func multiplyAddFloat() {
            let a: Float = 2.0
            let b: Float = 3.0
            let c: Float = 1.0

            let unfused = a * b + c
            let fused = c.addingProduct(a, b)
            let relaxed = Numeric.Relaxed.multiplyAdd(a, b, c)

            #expect(relaxed == unfused || relaxed == fused)
        }

        @Test
        func sumOfSquares() {
            // Common pattern: sum of squares
            let values: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]

            let strict = values.reduce(0.0) { $0 + $1 * $1 }
            let relaxed = values.reduce(0.0) {
                Numeric.Relaxed.multiplyAdd($1, $1, $0)
            }

            // Results should be close (within floating-point tolerance)
            let bound = max(strict, relaxed).ulp * Double(values.count) * 2
            #expect(abs(strict - relaxed) <= bound)
        }
    }

    // MARK: - Reduction Tests

    @Suite
    struct ReductionTests {

        @Test
        func arraySum() {
            // Summing an array should give approximately the same result
            let values = (0..<100).map { _ in Double.random(in: 1.0..<2.0) }

            let strict = values.reduce(0.0, +)
            let relaxed = values.reduce(0.0, Numeric.Relaxed.sum)

            // Both should be within reasonable error bounds
            let bound = max(strict, relaxed).ulp * Double(values.count)
            #expect(abs(strict - relaxed) <= bound)
        }

        @Test
        func arraySumFloat() {
            let values = (0..<100).map { _ in Float.random(in: 1.0..<2.0) }

            let strict = values.reduce(Float(0), +)
            let relaxed = values.reduce(Float(0), Numeric.Relaxed.sum)

            let bound = max(strict, relaxed).ulp * Float(values.count)
            #expect(abs(strict - relaxed) <= bound)
        }
    }

    // MARK: - Edge Cases

    @Suite
    struct EdgeCases {

        @Test
        func infinityHandling() {
            #expect(Numeric.Relaxed.sum(Double.infinity, 1.0) == Double.infinity)
            #expect(Numeric.Relaxed.sum(1.0, Double.infinity) == Double.infinity)
            #expect(Numeric.Relaxed.product(Double.infinity, 2.0) == Double.infinity)
        }

        @Test
        func nanHandling() {
            #expect(Numeric.Relaxed.sum(Double.nan, 1.0).isNaN)
            #expect(Numeric.Relaxed.sum(1.0, Double.nan).isNaN)
            #expect(Numeric.Relaxed.product(Double.nan, 1.0).isNaN)
        }

        @Test
        func negativeZero() {
            let result = Numeric.Relaxed.sum(-0.0, -0.0)
            #expect(result.sign == .minus)
        }
    }
}
