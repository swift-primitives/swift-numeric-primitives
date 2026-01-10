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
    /// Degrees divide a full rotation into 360 parts. Use degrees for
    /// human-readable angles or when working with degree-based formats.
    ///
    /// ```swift
    /// let angle: Degree<Double> = .right.half  // 45°
    /// let radians = angle.radians
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

    /// Access right angle (90°) based values.
    ///
    /// ```swift
    /// Degree<Double>.right.full              // 90°
    /// Degree<Double>.right.half              // 45°
    /// Degree<Double>.right.third             // 30°
    /// Degree<Double>.right.fraction<2, 3>()  // 60°
    /// ```
    @inlinable
    public static var right: Numeric.Angle.Degree.Right<RawValue> { .init() }

    /// Access straight angle (180°) based values.
    ///
    /// ```swift
    /// Degree<Double>.straight.full           // 180°
    /// Degree<Double>.straight.half           // 90°
    /// ```
    @inlinable
    public static var straight: Numeric.Angle.Degree.Straight<RawValue> { .init() }

    /// Access full rotation (360°) based values.
    ///
    /// ```swift
    /// Degree<Double>.full.full               // 360°
    /// Degree<Double>.full.half               // 180°
    /// Degree<Double>.full.third              // 120°
    /// Degree<Double>.full.fraction<1, 12>()  // 30°
    /// ```
    @inlinable
    public static var full: Numeric.Angle.Degree.Full<RawValue> { .init() }
}

// MARK: - Right Angle Accessor (90°)

extension Numeric.Angle.Degree {
    /// Accessor for right angle (90°) based values with compile-time fraction support.
    public struct Right<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 90 degrees (a right angle).
        @inlinable
        public var full: Degree<Scalar> { Degree(90) }

        /// 45 degrees (half a right angle).
        @inlinable
        public var half: Degree<Scalar> { Degree(45) }

        /// 30 degrees (a third of a right angle).
        @inlinable
        public var third: Degree<Scalar> { Degree(30) }

        /// 22.5 degrees (a quarter of a right angle).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(22.5) }

        /// Typealias for compile-time fraction of 90°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 90° with compile-time integer parameters.
        ///
        /// ```swift
        /// Degree<Double>.right.fraction<2, 3>()()  // 60°
        /// Degree<Double>.right.fraction<1, 6>()()  // 15°
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator>
        where Scalar: Sendable {
            .init(Degree(90 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Straight Angle Accessor (180°)

extension Numeric.Angle.Degree {
    /// Accessor for straight angle (180°) based values with compile-time fraction support.
    public struct Straight<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 180 degrees (a straight angle).
        @inlinable
        public var full: Degree<Scalar> { Degree(180) }

        /// 90 degrees (half a straight angle).
        @inlinable
        public var half: Degree<Scalar> { Degree(90) }

        /// 60 degrees (a third of a straight angle).
        @inlinable
        public var third: Degree<Scalar> { Degree(60) }

        /// 45 degrees (a quarter of a straight angle).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(45) }

        /// Typealias for compile-time fraction of 180°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 180° with compile-time integer parameters.
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator>
        where Scalar: Sendable {
            .init(Degree(180 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Full Rotation Accessor (360°)

extension Numeric.Angle.Degree {
    /// Accessor for full rotation (360°) based values with compile-time fraction support.
    public struct Full<Scalar: BinaryFloatingPoint>: Sendable {
        @usableFromInline
        internal init() {}

        /// 360 degrees (a full rotation).
        @inlinable
        public var full: Degree<Scalar> { Degree(360) }

        /// 180 degrees (half a rotation).
        @inlinable
        public var half: Degree<Scalar> { Degree(180) }

        /// 120 degrees (a third of a rotation).
        @inlinable
        public var third: Degree<Scalar> { Degree(120) }

        /// 90 degrees (a quarter of a rotation).
        @inlinable
        public var quarter: Degree<Scalar> { Degree(90) }

        /// 60 degrees (a sixth of a rotation).
        @inlinable
        public var sixth: Degree<Scalar> { Degree(60) }

        /// Typealias for compile-time fraction of 360°.
        public typealias Fraction<let Numerator: Int, let Denominator: Int> = Numeric.Fraction<Numerator, Denominator, Degree<Scalar>>

        /// Access arbitrary fraction of 360° with compile-time integer parameters.
        ///
        /// ```swift
        /// Degree<Double>.full.fraction<1, 12>()()  // 30°
        /// Degree<Double>.full.fraction<5, 6>()()   // 300°
        /// ```
        @inlinable
        public func fraction<let Numerator: Int, let Denominator: Int>() -> Fraction<Numerator, Denominator>
        where Scalar: Sendable {
            .init(Degree(360 * Scalar(Numerator) / Scalar(Denominator)))
        }
    }
}

// MARK: - Conversion

extension Tagged where Tag == Numeric.Angle.Radian, RawValue: BinaryFloatingPoint {
    /// The angle converted to degrees.
    @inlinable
    public var degrees: Degree<RawValue> {
        Degree(rawValue * 180 / .pi)
    }

    /// Creates a radian angle from a degree value.
    @inlinable
    public init(degrees: Degree<RawValue>) {
        self.init(degrees.rawValue * .pi / 180)
    }
}

extension Tagged where Tag == Numeric.Angle.Degree, RawValue: BinaryFloatingPoint {
    /// The angle converted to radians.
    @inlinable
    public var radians: Radian<RawValue> {
        Radian(rawValue * .pi / 180)
    }

    /// Creates a degree angle from a radian value.
    @inlinable
    public init(radians: Radian<RawValue>) {
        self.init(radians.rawValue * 180 / .pi)
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
