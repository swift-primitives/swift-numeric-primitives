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
    /// Phantom type tag for radian-valued angles.
    public enum Radian {}
}

extension Numeric.Angle.Radian {
    /// An angle measured in radians.
    ///
    /// Radians are the natural unit for angular measurement, representing
    /// the ratio of arc length to radius. Use radians for mathematical
    /// operations and trigonometric functions.
    ///
    /// ```swift
    /// let angle: Radian<Double> = .halfPi  // π/2
    /// let sine = Double.math.sin(angle.rawValue)
    /// ```
    public typealias Value<Scalar> = Tagged<Numeric.Angle.Radian, Scalar>
}

/// An angle measured in radians.
public typealias Radian<Scalar> = Numeric.Angle.Radian.Value<Scalar>

// MARK: - Common Angles

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: BinaryFloatingPoint {
    /// Zero radians.
    @inlinable
    public static var zero: Self { Self(0) }

    /// π radians (180 degrees).
    @inlinable
    public static var pi: Self { Self(.pi) }

    /// π/2 radians (90 degrees).
    @inlinable
    public static var halfPi: Self { Self(.pi / 2) }

    /// 2π radians (360 degrees).
    @inlinable
    public static var twoPi: Self { Self(.pi * 2) }

    /// π/4 radians (45 degrees).
    @inlinable
    public static var quarterPi: Self { Self(.pi / 4) }
}

// MARK: - Arithmetic

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue + rhs.rawValue)
    }

    @inlinable
    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(lhs.rawValue - rhs.rawValue)
    }
}

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: Swift.Numeric {
    @inlinable
    public static func * (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue * rhs)
    }

    @inlinable
    public static func * (lhs: RawValue, rhs: Self) -> Self {
        Self(lhs * rhs.rawValue)
    }
}

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: FloatingPoint {
    @inlinable
    public static func / (lhs: Self, rhs: RawValue) -> Self {
        Self(lhs.rawValue / rhs)
    }
}

// MARK: - Negation

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: SignedNumeric {
    @inlinable
    public static prefix func - (value: Self) -> Self {
        Self(-value.rawValue)
    }
}
