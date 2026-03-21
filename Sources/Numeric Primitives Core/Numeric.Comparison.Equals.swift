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

extension Numeric.Comparison {
    /// Accessor struct for equality comparisons with various modes.
    ///
    /// Access via the `.equals` property on numeric values:
    ///
    /// ```swift
    /// let x = 1.0 / 3.0 * 3.0
    /// x.equals.approximate(1.0, tolerance: 1e-15)
    /// x.equals.approximate(1.0, absolute: 1e-10, relative: 1e-5)
    /// ```
    public struct Equals<T> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Comparison.Equals: Sendable where T: Sendable {}

// MARK: - FloatingPoint Comparisons

extension Numeric.Comparison.Equals where T: FloatingPoint {
    /// Tests if two values are approximately equal within tolerance.
    ///
    /// Returns `true` if `|self - other| <= tolerance`.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - tolerance: Maximum allowed absolute difference.
    /// - Returns: `true` if values are within tolerance of each other.
    @inlinable
    public func approximate(_ other: T, tolerance: T) -> Bool {
        (value - other).magnitude <= tolerance
    }

    /// Tests if two values are approximately equal using combined tolerance.
    ///
    /// Returns `true` if `|self - other| <= absolute + relative * max(|self|, |other|)`.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - absolute: Absolute tolerance component.
    ///   - relative: Relative tolerance component (default 0).
    /// - Returns: `true` if values are within combined tolerance.
    @inlinable
    public func approximate(_ other: T, absolute: T, relative: T = .zero) -> Bool {
        let diff = (value - other).magnitude
        let scale = Swift.max(value.magnitude, other.magnitude)
        return diff <= absolute + relative * scale
    }
}

// MARK: - Signed Numeric Comparisons

extension Numeric.Comparison.Equals where T: SignedNumeric, T.Magnitude: Comparable {
    /// Tests if two values are approximately equal within tolerance.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - tolerance: Maximum allowed absolute difference.
    /// - Returns: `true` if values are within tolerance of each other.
    @inlinable
    public func approximate(_ other: T, tolerance: T.Magnitude) -> Bool {
        (value - other).magnitude <= tolerance
    }
}

// MARK: - Access via .equals property

extension FloatingPoint where Self: Sendable {
    /// Access equality comparisons.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let x = 1.0 / 3.0 * 3.0
    /// if x.equals.approximate(1.0, tolerance: 1e-15) {
    ///     print("Close enough!")
    /// }
    /// ```
    @inlinable
    public var equals: Numeric.Comparison.Equals<Self> {
        Numeric.Comparison.Equals(self)
    }
}

extension SignedNumeric where Self: Sendable {
    /// Access equality comparisons.
    @inlinable
    public var equals: Numeric.Comparison.Equals<Self> {
        Numeric.Comparison.Equals(self)
    }
}
