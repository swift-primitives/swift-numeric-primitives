// Augmented.Tests.swift

import Real_Primitives
import Testing

// MARK: - Numeric.Augmented Tests (Parallel Namespace per [TEST-004])

@Suite("Numeric.Augmented")
struct NumericAugmentedTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericAugmentedTests.Unit {
    @Test
    func `exact product has zero tail`() {
        let (head, tail) = Numeric.Augmented.product(2.0, 3.0)
        #expect(head == 6.0)
        #expect(tail == 0.0)
    }

    @Test
    func `product captures rounding error`() {
        let a = 1.0 + Double.ulpOfOne
        let b = 1.0 - Double.ulpOfOne
        let (head, tail) = Numeric.Augmented.product(a, b)

        #expect(head == a * b)
        #expect(tail.magnitude <= head.ulp / 2)
    }

    @Test
    func `product with zero`() {
        let (head, tail) = Numeric.Augmented.product(0.0, 42.0)
        #expect(head == 0.0)
        #expect(tail == 0.0)
    }

    @Test
    func `product with Float`() {
        let a: Float = 1.0 + Float.ulpOfOne
        let b: Float = 1.0 - Float.ulpOfOne
        let (head, tail) = Numeric.Augmented.product(a, b)
        #expect(head == a * b)
        #expect(tail.magnitude <= head.ulp / 2)
    }

    @Test
    func `exact sum has zero tail`() {
        let (head, tail) = Numeric.Augmented.sum(1.0, 2.0)
        #expect(head == 3.0)
        #expect(tail == 0.0)
    }

    @Test
    func `sum captures cancellation error`() {
        let big = 1e16
        let small = 1.0
        let (head, tail) = Numeric.Augmented.sum(big, small)

        #expect(head == big + small)
        #expect(tail.magnitude <= head.ulp / 2)
    }

    @Test
    func `sum of opposites cancels exactly`() {
        let x = Double.greatestFiniteMagnitude
        let y = -Double.greatestFiniteMagnitude
        let (head, tail) = Numeric.Augmented.sum(x, y)
        #expect(head == 0.0)
        #expect(tail == 0.0)
    }

    @Test
    func `sum is commutative`() {
        let a = 1.5
        let b = 0.000001
        let (head1, tail1) = Numeric.Augmented.sum(a, b)
        let (head2, tail2) = Numeric.Augmented.sum(b, a)
        #expect(head1 == head2)
        #expect(tail1 == tail2)
    }

    @Test
    func `fast sum basic operation`() {
        let big = 1e10
        let small = 1.0
        let (head, tail) = Numeric.Augmented.sum(large: big, small: small)
        #expect(head == big + small)
        #expect(tail.magnitude <= head.ulp / 2)
    }

    @Test
    func `fast sum matches two sum when ordered correctly`() {
        let a = 100.0
        let b = 0.001
        let twoSum = Numeric.Augmented.sum(a, b)
        let fastSum = Numeric.Augmented.sum(large: a, small: b)
        #expect(twoSum.head == fastSum.head)
        #expect(twoSum.tail == fastSum.tail)
    }
}

// MARK: - Edge Case Tests

extension NumericAugmentedTests.EdgeCase {
    @Test
    func `infinity handling in sum`() {
        let (head, _) = Numeric.Augmented.sum(0.0, Double.infinity)
        #expect(head == Double.infinity)

        let (head2, _) = Numeric.Augmented.sum(Double.infinity, 0.0)
        #expect(head2 == Double.infinity)

        let (head3, _) = Numeric.Augmented.sum(Double.infinity, Double.infinity)
        #expect(head3 == Double.infinity)
    }

    @Test
    func `NaN handling`() {
        let (head, _) = Numeric.Augmented.sum(Double.nan, 1.0)
        #expect(head.isNaN)

        let (head2, _) = Numeric.Augmented.sum(1.0, Double.nan)
        #expect(head2.isNaN)

        let (head3, _) = Numeric.Augmented.product(Double.nan, 1.0)
        #expect(head3.isNaN)
    }

    @Test
    func `signed zeros`() {
        let (head, _) = Numeric.Augmented.sum(+0.0, -0.0)
        #expect(head.sign == .plus)

        let (head2, _) = Numeric.Augmented.sum(-0.0, +0.0)
        #expect(head2.sign == .plus)

        let (head3, _) = Numeric.Augmented.sum(-0.0, -0.0)
        #expect(head3.sign == .minus)
    }

    @Test
    func `smallest values`() {
        let x = Double.leastNonzeroMagnitude
        let y = -Double.leastNonzeroMagnitude
        let (head, tail) = Numeric.Augmented.sum(x, y)
        #expect(head == 0.0)
        #expect(tail == 0.0)
    }
}

// MARK: - Integration Tests

extension NumericAugmentedTests.Integration {
    @Test
    func `compensated sum captures lost precision`() {
        let big = 1e16
        let small = 1.0

        let naiveSum = big + small
        #expect(naiveSum == big)  // 1.0 is lost

        let (head, tail) = Numeric.Augmented.sum(big, small)
        #expect(head == big)
        #expect(tail == small)
    }

    @Test
    func `product error capture`() {
        let a = 1.0000001
        let b = 1.0000001

        let naiveProduct = a * b
        let (head, tail) = Numeric.Augmented.product(a, b)

        #expect(head == naiveProduct)
        #expect(tail != 0.0)
        #expect(tail.magnitude < head.ulp)
    }
}
