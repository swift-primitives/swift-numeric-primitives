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
struct AugmentedTests {

    // MARK: - Product Tests

    @Suite
    struct ProductTests {

        @Test
        func exactProduct() {
            // Products that are exactly representable should have zero tail
            let (head, tail) = Numeric.Augmented.product(2.0, 3.0)
            #expect(head == 6.0)
            #expect(tail == 0.0)
        }

        @Test
        func productWithRoundingError() {
            // (1 + ulp) * (1 - ulp) = 1 - ulp^2, but ulp^2 is lost
            let a = 1.0 + Double.ulpOfOne
            let b = 1.0 - Double.ulpOfOne
            let (head, tail) = Numeric.Augmented.product(a, b)

            // head should be the IEEE 754 product
            #expect(head == a * b)

            // tail should capture the error (ulp^2)
            // The exact product is 1 - ulp^2, head is ~1, tail is ~ -ulp^2
            #expect(tail.magnitude <= head.ulp / 2)
        }

        @Test
        func productZero() {
            let (head, tail) = Numeric.Augmented.product(0.0, 42.0)
            #expect(head == 0.0)
            #expect(tail == 0.0)
        }

        @Test
        func productFloat() {
            let a: Float = 1.0 + Float.ulpOfOne
            let b: Float = 1.0 - Float.ulpOfOne
            let (head, tail) = Numeric.Augmented.product(a, b)
            #expect(head == a * b)
            #expect(tail.magnitude <= head.ulp / 2)
        }
    }

    // MARK: - Sum Tests

    @Suite
    struct SumTests {

        @Test
        func exactSum() {
            // Sums that are exactly representable should have zero tail
            let (head, tail) = Numeric.Augmented.sum(1.0, 2.0)
            #expect(head == 3.0)
            #expect(tail == 0.0)
        }

        @Test
        func sumWithCancellation() {
            // When magnitudes differ greatly, small value is lost in head
            let big = 1e16
            let small = 1.0
            let (head, tail) = Numeric.Augmented.sum(big, small)

            // head is the IEEE 754 sum (small may be lost)
            #expect(head == big + small)

            // tail captures what was lost
            #expect(tail.magnitude <= head.ulp / 2)
        }

        @Test
        func sumOpposites() {
            // Exact cancellation
            let x = Double.greatestFiniteMagnitude
            let y = -Double.greatestFiniteMagnitude
            let (head, tail) = Numeric.Augmented.sum(x, y)
            #expect(head == 0.0)
            #expect(tail == 0.0)
        }

        @Test
        func sumSmallest() {
            // Smallest values
            let x = Double.leastNonzeroMagnitude
            let y = -Double.leastNonzeroMagnitude
            let (head, tail) = Numeric.Augmented.sum(x, y)
            #expect(head == 0.0)
            #expect(tail == 0.0)
        }

        @Test
        func sumFloat() {
            let (head, tail) = Numeric.Augmented.sum(Float(1e8), Float(1.0))
            #expect(head == Float(1e8) + Float(1.0))
            #expect(tail.magnitude <= head.ulp / 2)
        }

        @Test
        func sumCommutative() {
            // twoSum should give same result regardless of argument order
            let a = 1.5
            let b = 0.000001
            let (head1, tail1) = Numeric.Augmented.sum(a, b)
            let (head2, tail2) = Numeric.Augmented.sum(b, a)
            #expect(head1 == head2)
            #expect(tail1 == tail2)
        }
    }

    // MARK: - Fast Sum Tests

    @Suite
    struct FastSumTests {

        @Test
        func fastSumBasic() {
            let big = 1e10
            let small = 1.0
            let (head, tail) = Numeric.Augmented.sum(large: big, small: small)
            #expect(head == big + small)
            #expect(tail.magnitude <= head.ulp / 2)
        }

        @Test
        func fastSumMatchesTwoSum() {
            // When ordering is correct, fastTwoSum should match twoSum
            let a = 100.0
            let b = 0.001
            let twoSum = Numeric.Augmented.sum(a, b)
            let fastSum = Numeric.Augmented.sum(large: a, small: b)
            #expect(twoSum.head == fastSum.head)
            #expect(twoSum.tail == fastSum.tail)
        }

        @Test
        func fastSumExact() {
            // Exactly representable sums
            let (head, tail) = Numeric.Augmented.sum(large: 10.0, small: 5.0)
            #expect(head == 15.0)
            #expect(tail == 0.0)
        }
    }

    // MARK: - Edge Cases

    @Suite
    struct EdgeCases {

        @Test
        func infinityHandling() {
            let (head, _) = Numeric.Augmented.sum(0.0, Double.infinity)
            #expect(head == Double.infinity)

            let (head2, _) = Numeric.Augmented.sum(Double.infinity, 0.0)
            #expect(head2 == Double.infinity)

            let (head3, _) = Numeric.Augmented.sum(Double.infinity, Double.infinity)
            #expect(head3 == Double.infinity)
        }

        @Test
        func nanHandling() {
            let (head, _) = Numeric.Augmented.sum(Double.nan, 1.0)
            #expect(head.isNaN)

            let (head2, _) = Numeric.Augmented.sum(1.0, Double.nan)
            #expect(head2.isNaN)

            let (head3, _) = Numeric.Augmented.product(Double.nan, 1.0)
            #expect(head3.isNaN)
        }

        @Test
        func signedZeros() {
            // (+0) + (-0) == +0
            let (head, _) = Numeric.Augmented.sum(+0.0, -0.0)
            #expect(head.sign == .plus)

            // (-0) + (+0) == +0
            let (head2, _) = Numeric.Augmented.sum(-0.0, +0.0)
            #expect(head2.sign == .plus)

            // (-0) + (-0) == -0
            let (head3, _) = Numeric.Augmented.sum(-0.0, -0.0)
            #expect(head3.sign == .minus)
        }
    }

    // MARK: - Practical Applications

    @Suite
    struct Applications {

        @Test
        func compensatedSum() {
            // Demonstrate that augmented sum captures lost precision
            let big = 1e16
            let small = 1.0

            // Naive addition loses the small value
            let naiveSum = big + small
            #expect(naiveSum == big)  // 1.0 is lost

            // Augmented sum captures what was lost
            let (head, tail) = Numeric.Augmented.sum(big, small)
            #expect(head == big)      // Same as naive
            #expect(tail == small)    // But we captured the 1.0!

            // We can use head + tail to recover full precision
            // (in a higher-precision context or via compensation)
            #expect(head + tail == big)  // Still loses in FP...
            // But tail preserves the information for algorithms that need it
        }

        @Test
        func productErrorCapture() {
            // Two values whose product isn't exactly representable
            let a = 1.0000001
            let b = 1.0000001

            let naiveProduct = a * b
            let (head, tail) = Numeric.Augmented.product(a, b)

            // head matches naive product
            #expect(head == naiveProduct)

            // tail captures the rounding error
            #expect(tail != 0.0)
            #expect(tail.magnitude < head.ulp)
        }
    }
}
