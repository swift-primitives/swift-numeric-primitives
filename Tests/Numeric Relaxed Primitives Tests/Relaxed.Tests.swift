// Relaxed.Tests.swift

import Numeric_Primitives_Test_Support
import Testing

// MARK: - Numeric.Relaxed Tests (Parallel Namespace per [TEST-004])

@Suite("Numeric.Relaxed")
struct NumericRelaxedTests {
    @Suite struct Unit {}
    @Suite struct EdgeCase {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

// MARK: - Unit Tests

extension NumericRelaxedTests.Unit {
    @Test
    func `sum equals standard addition`() {
        let a = 1.5
        let b = 2.5
        #expect(Numeric.Relaxed.sum(a, b) == a + b)
    }

    @Test
    func `sum with Float`() {
        let a: Float = 1.5
        let b: Float = 2.5
        #expect(Numeric.Relaxed.sum(a, b) == a + b)
    }

    @Test
    func `sum with negative is subtraction`() {
        let a = 10.0
        let b = 3.0
        #expect(Numeric.Relaxed.sum(a, -b) == a - b)
    }

    @Test
    func `sum with zero`() {
        #expect(Numeric.Relaxed.sum(0.0, 0.0) == 0.0)
        #expect(Numeric.Relaxed.sum(5.0, 0.0) == 5.0)
        #expect(Numeric.Relaxed.sum(0.0, 5.0) == 5.0)
    }

    @Test
    func `product equals standard multiplication`() {
        let a = 2.0
        let b = 3.0
        #expect(Numeric.Relaxed.product(a, b) == a * b)
    }

    @Test
    func `product with Float`() {
        let a: Float = 2.0
        let b: Float = 3.0
        #expect(Numeric.Relaxed.product(a, b) == a * b)
    }

    @Test
    func `product with zero`() {
        #expect(Numeric.Relaxed.product(0.0, 5.0) == 0.0)
        #expect(Numeric.Relaxed.product(5.0, 0.0) == 0.0)
    }

    @Test
    func `product with one`() {
        #expect(Numeric.Relaxed.product(1.0, 5.0) == 5.0)
        #expect(Numeric.Relaxed.product(5.0, 1.0) == 5.0)
    }

    @Test
    func `multiplyAdd basic operation`() {
        let a = 2.0
        let b = 3.0
        let c = 1.0

        let unfused = a * b + c
        let fused = c.addingProduct(a, b)
        let relaxed = Numeric.Relaxed.multiplyAdd(a, b, c)

        #expect(relaxed == unfused || relaxed == fused)
    }

    @Test
    func `multiplyAdd with Float`() {
        let a: Float = 2.0
        let b: Float = 3.0
        let c: Float = 1.0

        let unfused = a * b + c
        let fused = c.addingProduct(a, b)
        let relaxed = Numeric.Relaxed.multiplyAdd(a, b, c)

        #expect(relaxed == unfused || relaxed == fused)
    }
}

// MARK: - Edge Case Tests

extension NumericRelaxedTests.EdgeCase {
    @Test
    func `infinity handling`() {
        #expect(Numeric.Relaxed.sum(Double.infinity, 1.0) == Double.infinity)
        #expect(Numeric.Relaxed.sum(1.0, Double.infinity) == Double.infinity)
        #expect(Numeric.Relaxed.product(Double.infinity, 2.0) == Double.infinity)
    }

    @Test
    func `NaN handling`() {
        #expect(Numeric.Relaxed.sum(Double.nan, 1.0).isNaN)
        #expect(Numeric.Relaxed.sum(1.0, Double.nan).isNaN)
        #expect(Numeric.Relaxed.product(Double.nan, 1.0).isNaN)
    }

    @Test
    func `negative zero`() {
        let result = Numeric.Relaxed.sum(-0.0, -0.0)
        #expect(result.sign == .minus)
    }
}

// MARK: - Integration Tests

extension NumericRelaxedTests.Integration {
    @Test
    func `sum of squares pattern`() {
        let values: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0]

        let strict = values.reduce(0.0) { $0 + $1 * $1 }
        let relaxed = values.reduce(0.0) {
            Numeric.Relaxed.multiplyAdd($1, $1, $0)
        }

        let bound = max(strict, relaxed).ulp * Double(values.count) * 2
        #expect(abs(strict - relaxed) <= bound)
    }

    @Test
    func `array sum within error bounds`() {
        let values = (0..<100).map { _ in Double.random(in: 1.0..<2.0) }

        let strict = values.reduce(0.0, +)
        let relaxed = values.reduce(0.0, Numeric.Relaxed.sum)

        let bound = max(strict, relaxed).ulp * Double(values.count)
        #expect(abs(strict - relaxed) <= bound)
    }

    @Test
    func `array sum with Float within error bounds`() {
        let values = (0..<100).map { _ in Float.random(in: 1.0..<2.0) }

        let strict = values.reduce(Float(0), +)
        let relaxed = values.reduce(Float(0), Numeric.Relaxed.sum)

        let bound = max(strict, relaxed).ulp * Float(values.count)
        #expect(abs(strict - relaxed) <= bound)
    }
}
