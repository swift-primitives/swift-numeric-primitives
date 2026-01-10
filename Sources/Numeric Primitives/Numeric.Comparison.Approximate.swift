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
    /// Accessor struct for approximate equality comparisons.
    ///
    /// Access via the `.approximate` property on numeric values:
    ///
    /// ```swift
    /// let x = 1.0 / 3.0 * 3.0
    /// x.approximate.equals(1.0, tolerance: 1e-15)
    /// x.approximate.equals(1.0, absolute: 1e-10, relative: 1e-5)
    /// ```
    public struct Approximate<T>: Sendable where T: Sendable {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

// MARK: - FloatingPoint Comparisons

extension Numeric.Comparison.Approximate where T: FloatingPoint {
    /// Tests if two values are approximately equal within tolerance.
    ///
    /// Returns `true` if `|self - other| <= tolerance`.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - tolerance: Maximum allowed absolute difference.
    /// - Returns: `true` if values are within tolerance of each other.
    @inlinable
    public func equals(_ other: T, tolerance: T) -> Bool {
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
    public func equals(_ other: T, absolute: T, relative: T = .zero) -> Bool {
        let diff = (value - other).magnitude
        let scale = Swift.max(value.magnitude, other.magnitude)
        return diff <= absolute + relative * scale
    }
}

// MARK: - Signed Numeric Comparisons

extension Numeric.Comparison.Approximate where T: SignedNumeric, T.Magnitude: Comparable {
    /// Tests if two values are approximately equal within tolerance.
    ///
    /// - Parameters:
    ///   - other: The value to compare against.
    ///   - tolerance: Maximum allowed absolute difference.
    /// - Returns: `true` if values are within tolerance of each other.
    @inlinable
    public func equals(_ other: T, tolerance: T.Magnitude) -> Bool {
        (value - other).magnitude <= tolerance
    }
}
