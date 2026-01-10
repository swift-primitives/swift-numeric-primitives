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

// MARK: - Addition

extension Numeric.Complex {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.real + rhs.real, lhs.imaginary + rhs.imaginary)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    @inlinable
    public static func + (lhs: Self, rhs: Scalar) -> Self {
        Self(lhs.real + rhs, lhs.imaginary)
    }

    @inlinable
    public static func + (lhs: Scalar, rhs: Self) -> Self {
        Self(lhs + rhs.real, rhs.imaginary)
    }
}

// MARK: - Subtraction

extension Numeric.Complex {
    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.real - rhs.real, lhs.imaginary - rhs.imaginary)
    }

    @inlinable
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }

    @inlinable
    public static func - (lhs: Self, rhs: Scalar) -> Self {
        Self(lhs.real - rhs, lhs.imaginary)
    }

    @inlinable
    public static func - (lhs: Scalar, rhs: Self) -> Self {
        Self(lhs - rhs.real, -rhs.imaginary)
    }
}

// MARK: - Negation

extension Numeric.Complex {
    @inlinable
    public static prefix func - (z: Self) -> Self {
        Self(-z.real, -z.imaginary)
    }
}

// MARK: - Multiplication

extension Numeric.Complex {
    /// (a + bi)(c + di) = (ac - bd) + (ad + bc)i
    @inlinable
    public static func * (lhs: Self, rhs: Self) -> Self {
        Self(
            lhs.real * rhs.real - lhs.imaginary * rhs.imaginary,
            lhs.real * rhs.imaginary + lhs.imaginary * rhs.real
        )
    }

    @inlinable
    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    @inlinable
    public static func * (lhs: Self, rhs: Scalar) -> Self {
        Self(lhs.real * rhs, lhs.imaginary * rhs)
    }

    @inlinable
    public static func * (lhs: Scalar, rhs: Self) -> Self {
        Self(lhs * rhs.real, lhs * rhs.imaginary)
    }
}

// MARK: - Division

extension Numeric.Complex {
    /// (a + bi)/(c + di) = ((ac + bd) + (bc - ad)i) / (c² + d²)
    @inlinable
    public static func / (lhs: Self, rhs: Self) -> Self {
        let denom = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
        return Self(
            (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / denom,
            (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / denom
        )
    }

    @inlinable
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    @inlinable
    public static func / (lhs: Self, rhs: Scalar) -> Self {
        Self(lhs.real / rhs, lhs.imaginary / rhs)
    }

    @inlinable
    public static func / (lhs: Scalar, rhs: Self) -> Self {
        Self(lhs, .zero) / rhs
    }
}

// MARK: - Conjugate

extension Numeric.Complex {
    /// Returns the complex conjugate.
    ///
    /// The conjugate of `a + bi` is `a - bi`.
    @inlinable
    public static func conjugate(of z: Self) -> Self {
        Self(z.real, -z.imaginary)
    }

    /// The complex conjugate.
    @inlinable
    public var conjugate: Self {
        Self.conjugate(of: self)
    }
}

// MARK: - Reciprocal

extension Numeric.Complex {
    /// Returns the multiplicative inverse.
    ///
    /// The reciprocal of `z` is `1/z = conjugate(z) / |z|²`.
    @inlinable
    public static func reciprocal(of z: Self) -> Self {
        let denom = z.real * z.real + z.imaginary * z.imaginary
        return Self(z.real / denom, -z.imaginary / denom)
    }

    /// The multiplicative inverse.
    @inlinable
    public var reciprocal: Self {
        Self.reciprocal(of: self)
    }
}
