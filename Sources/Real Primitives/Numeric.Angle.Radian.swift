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
    /// let angle: Radian<Double> = .pi.half  // π/2
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

    /// Access π-based angle values.
    ///
    /// ```swift
    /// Radian<Double>.pi.half              // π/2
    /// Radian<Double>.pi.quarter           // π/4
    /// Radian<Double>.pi.two               // 2π
    /// Radian<Double>.pi.fraction<1, 3>()  // π/3
    /// ```
    @inlinable
    public static var pi: Numeric.Angle.Radian.Pi<RawValue> { .init() }
}

// MARK: - Pi Accessor

extension Numeric.Angle.Radian {
    /// Accessor for π-based angle values with compile-time fraction support.
    ///
    /// Provides common angle fractions and arbitrary fractions via integer
    /// generic parameters (SE-0452).
    public struct Pi<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// π radians (180 degrees).
        @inlinable
        public var full: Radian<Scalar> { Radian(.pi) }

        /// π/2 radians (90 degrees).
        @inlinable
        public var half: Radian<Scalar> { Radian(.pi / 2) }

        /// π/4 radians (45 degrees).
        @inlinable
        public var quarter: Radian<Scalar> { Radian(.pi / 4) }

        /// 2π radians (360 degrees).
        @inlinable
        public var two: Radian<Scalar> { Radian(.pi * 2) }

        /// π/3 radians (60 degrees).
        @inlinable
        public var third: Radian<Scalar> { Radian(.pi / 3) }

        /// π/6 radians (30 degrees).
        @inlinable
        public var sixth: Radian<Scalar> { Radian(.pi / 6) }

        /// Typealias for compile-time fraction of π.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Radian<Scalar>>

        /// Access arbitrary fraction of π with compile-time integer parameters.
        ///
        /// ```swift
        /// Radian<Double>.pi.fraction<1, 3>()()  // π/3
        /// Radian<Double>.pi.fraction<3, 4>()()  // 3π/4
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator>
        where Scalar: Sendable {
            .init(Radian(.pi * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
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
