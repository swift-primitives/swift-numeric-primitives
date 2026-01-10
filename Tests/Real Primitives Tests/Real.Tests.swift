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
struct RealTests {

    @Test
    func floatConformsToReal() {
        // Float should conform to Numeric.Real
        func useReal<T: Numeric.Real>(_ value: T) -> T {
            T.math.sin(value)
        }

        let result = useReal(Float.pi / 2)
        #expect(result.equals.approximate(1.0, tolerance: 1e-5))
    }

    @Test
    func doubleConformsToReal() {
        func useReal<T: Numeric.Real>(_ value: T) -> T {
            T.math.sin(value)
        }

        let result = useReal(Double.pi / 2)
        #expect(result.equals.approximate(1.0, tolerance: 1e-10))
    }

    @Test
    func radianType() {
        let angle: Radian<Double> = .pi.half
        #expect(angle.rawValue.equals.approximate(Double.pi / 2, tolerance: 1e-15))

        let degrees = angle.degrees
        #expect(degrees.rawValue.equals.approximate(90.0, tolerance: 1e-10))
    }

    @Test
    func degreeType() {
        let angle: Degree<Double> = .right.full
        #expect(angle.rawValue.equals.approximate(90.0, tolerance: 1e-15))

        let radians = angle.radians
        #expect(radians.rawValue.equals.approximate(Double.pi / 2, tolerance: 1e-10))
    }

    @Test
    func angleConversion() {
        let deg: Degree<Double> = 180
        let rad = Radian(degrees: deg)
        #expect(rad.rawValue.equals.approximate(Double.pi, tolerance: 1e-10))
    }

    // MARK: - Float16 Tests

    #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
        @Test
    func float16ConformsToReal() {
        func useReal<T: Numeric.Real>(_ value: T) -> T {
            T.math.sin(value)
        }

        let result = useReal(Float16.pi / 2)
        #expect(result.equals.approximate(1.0, tolerance: 1e-2))
    }

        @Test
    func float16BasicOperations() {
        // Test basic math operations
        let x: Float16 = 2.0
        let y: Float16 = 3.0

        // sqrt
        #expect(Float16.math.sqrt(4.0).equals.approximate(2.0, tolerance: 1e-2))

        // pow
        #expect(Float16.math.pow(x, y).equals.approximate(8.0, tolerance: 1e-1))

        // exp and log
        let e = Float16.math.exp(1.0)
        #expect(e.equals.approximate(2.718, tolerance: 1e-1))
        #expect(Float16.math.log(e).equals.approximate(1.0, tolerance: 1e-2))
    }

        @Test
    func float16Trigonometry() {
        // sin(π/2) = 1
        #expect(Float16.math.sin(Float16.pi / 2).equals.approximate(1.0, tolerance: 1e-2))

        // cos(0) = 1
        #expect(Float16.math.cos(0).equals.approximate(1.0, tolerance: 1e-3))

        // tan(π/4) ≈ 1
        #expect(Float16.math.tan(Float16.pi / 4).equals.approximate(1.0, tolerance: 1e-2))
    }

        @Test
    func float16Root() {
        // cube root of 8 = 2
        #expect(Float16.math.root(8.0, 3).equals.approximate(2.0, tolerance: 1e-2))

        // cube root of -8 = -2
        #expect(Float16.math.root(-8.0, 3).equals.approximate(-2.0, tolerance: 1e-2))
    }

        @Test
    func float16Hypot() {
        // 3² + 4² = 5²
        #expect(Float16.math.hypot(3.0, 4.0).equals.approximate(5.0, tolerance: 1e-2))

        // Infinity handling
        #expect(Float16.math.hypot(.infinity, 0).isInfinite)
        #expect(Float16.math.hypot(0, .infinity).isInfinite)
    }
    #endif
}
