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
        #expect(result.approximate.equals(1.0, tolerance: 1e-5))
    }

    @Test
    func doubleConformsToReal() {
        func useReal<T: Numeric.Real>(_ value: T) -> T {
            T.math.sin(value)
        }

        let result = useReal(Double.pi / 2)
        #expect(result.approximate.equals(1.0, tolerance: 1e-10))
    }

    @Test
    func radianType() {
        let angle: Radian<Double> = .halfPi
        #expect(angle.rawValue.approximate.equals(Double.pi / 2, tolerance: 1e-15))

        let degrees = angle.degrees
        #expect(degrees.rawValue.approximate.equals(90.0, tolerance: 1e-10))
    }

    @Test
    func degreeType() {
        let angle: Degree<Double> = .right
        #expect(angle.rawValue.approximate.equals(90.0, tolerance: 1e-15))

        let radians = angle.radians
        #expect(radians.rawValue.approximate.equals(Double.pi / 2, tolerance: 1e-10))
    }

    @Test
    func angleConversion() {
        let deg: Degree<Double> = 180
        let rad = Radian(degrees: deg)
        #expect(rad.rawValue.approximate.equals(Double.pi, tolerance: 1e-10))
    }
}
