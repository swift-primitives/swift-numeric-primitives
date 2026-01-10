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

extension Numeric.Angle {
    /// Phantom type tag for degree-valued angles.
    public enum Degree {}
}

extension Numeric.Angle.Degree {
    /// An angle measured in degrees.
    ///
    /// Degrees are commonly used for human-readable angle values.
    /// Convert to radians for mathematical operations.
    ///
    /// ```swift
    /// let angle: Degree<Double> = 90
    /// let radians = Radian(degrees: angle)  // π/2
    /// ```
    public typealias Value<Scalar> = Tagged<Numeric.Angle.Degree, Scalar>
}

/// An angle measured in degrees.
public typealias Degree<Scalar> = Numeric.Angle.Degree.Value<Scalar>

// MARK: - Common Angles

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Zero degrees.
    @inlinable
    public static var zero: Self { Self(0) }

    /// 90 degrees.
    @inlinable
    public static var right: Self { Self(90) }

    /// 180 degrees.
    @inlinable
    public static var straight: Self { Self(180) }

    /// 360 degrees.
    @inlinable
    public static var full: Self { Self(360) }

    /// 45 degrees.
    @inlinable
    public static var halfRight: Self { Self(45) }
}

// MARK: - Conversion

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Creates a radian angle from degrees.
    @inlinable
    public init(degrees: Degree<RawValue>) {
        self.init(degrees.rawValue * .pi / 180)
    }
}

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Creates a degree angle from radians.
    @inlinable
    public init(radians: Radian<RawValue>) {
        self.init(radians.rawValue * 180 / .pi)
    }
}

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Converts to degrees.
    @inlinable
    public var degrees: Degree<RawValue> {
        Degree(radians: self)
    }
}

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: BinaryFloatingPoint {
    /// Converts to radians.
    @inlinable
    public var radians: Radian<RawValue> {
        Radian(degrees: self)
    }
}

// MARK: - Arithmetic

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue + rhs.rawValue)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue - rhs.rawValue)
    }
}

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: Swift.Numeric {
    @inlinable
    public static func * (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue * rhs)
    }

    @inlinable
    public static func * (lhs: RawValue, rhs: Self) -> Self {
        Self(lhs * rhs.rawValue)
    }
}

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: FloatingPoint {
    @inlinable
    public static func / (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue / rhs)
    }
}

// MARK: - Negation

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: SignedNumeric {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        Self(-value.rawValue)
    }
}
