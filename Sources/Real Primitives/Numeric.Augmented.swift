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

extension Numeric {
    /// Error-free transformations for floating-point arithmetic.
    ///
    /// Augmented arithmetic operations return both the rounded result and
    /// the rounding error, enabling higher-precision computations without
    /// arbitrary-precision types.
    ///
    /// ## Overview
    ///
    /// When floating-point operations round, information is lost. Augmented
    /// arithmetic captures this lost information as a separate "tail" value:
    ///
    /// ```swift
    /// let (head, tail) = Numeric.Augmented.product(a, b)
    /// // Mathematically: a × b = head + tail (exactly)
    /// ```
    ///
    /// ## Use Cases
    ///
    /// - **Accurate summation**: Kahan summation and similar algorithms
    /// - **Extended precision**: Implementing double-double arithmetic
    /// - **Error analysis**: Computing error bounds for numerical algorithms
    /// - **Dot products**: Accurate inner products without overflow
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Compute a more accurate sum of an array
    /// func kahanSum(_ values: [Double]) -> Double {
    ///     var sum = 0.0
    ///     var compensation = 0.0
    ///     for value in values {
    ///         let (s, c) = Numeric.Augmented.sum(sum, value - compensation)
    ///         compensation = c
    ///         sum = s
    ///     }
    ///     return sum
    /// }
    /// ```
    public enum Augmented {}
}

// MARK: - Product

extension Numeric.Augmented {
    /// The product `a * b` represented as an implicit sum `head + tail`.
    ///
    /// `head` is the correctly rounded value of `a * b`. If no overflow or
    /// underflow occurs, `tail` represents the rounding error incurred in
    /// computing `head`, such that the exact product equals `head + tail`.
    ///
    /// This operation is sometimes called "twoProd" or "twoProduct".
    ///
    /// - Parameters:
    ///   - a: First multiplicand.
    ///   - b: Second multiplicand.
    /// - Returns: A tuple `(head, tail)` where `head` is the rounded product
    ///   and `tail` is the rounding error.
    ///
    /// ## Edge Cases
    ///
    /// - `head` is always the IEEE 754 product `a * b`.
    /// - If `head` is not finite, `tail` is unspecified.
    /// - Near underflow, `tail` may be rounded or zero even if inexact.
    /// - If `head` is zero, `tail` is also zero.
    ///
    /// ## Postconditions
    ///
    /// - If `head` is normal, then `abs(tail) < head.ulp`.
    /// - With IEEE 754 default rounding, `abs(tail) <= head.ulp/2`.
    /// - If both are normal, `a * b == head + tail` exactly (as reals).
    ///
    /// ## Example
    ///
    /// ```swift
    /// let a = 1.0 + Double.ulpOfOne
    /// let b = 1.0 - Double.ulpOfOne
    /// let (head, tail) = Numeric.Augmented.product(a, b)
    /// // head ≈ 1.0, tail captures the small error
    /// ```
    @inlinable
    public static func product<T: FloatingPoint>(
        _ a: T,
        _ b: T
    ) -> (head: T, tail: T) {
        let head = a * b
        let tail = (-head).addingProduct(a, b)
        return (head, tail)
    }
}

// MARK: - Sum

extension Numeric.Augmented {
    /// The sum `a + b` represented as an implicit sum `head + tail`.
    ///
    /// `head` is the correctly rounded value of `a + b`. `tail` is the
    /// rounding error from that computation.
    ///
    /// This operation is sometimes called "twoSum". Unlike `sum(large:small:)`,
    /// this works correctly regardless of the relative magnitudes of `a` and `b`.
    ///
    /// - Parameters:
    ///   - a: First summand.
    ///   - b: Second summand.
    /// - Returns: A tuple `(head, tail)` where `head` is the rounded sum
    ///   and `tail` is the rounding error.
    ///
    /// ## Edge Cases
    ///
    /// - `head` is always the IEEE 754 sum `a + b`.
    /// - If `head` is not finite, `tail` is unspecified.
    ///
    /// ## Postconditions
    ///
    /// - If `head` is normal, then `abs(tail) < head.ulp`.
    /// - With IEEE 754 default rounding, `abs(tail) <= head.ulp/2`.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let big = 1e16
    /// let small = 1.0
    /// let (head, tail) = Numeric.Augmented.sum(big, small)
    /// // head == 1e16 (small is lost), tail == 1.0 (captured)
    /// ```
    @inlinable
    public static func sum<T: FloatingPoint>(
        _ a: T,
        _ b: T
    ) -> (head: T, tail: T) {
        let head = a + b
        let x = head - b
        let y = head - x
        let tail = (a - x) + (b - y)
        return (head, tail)
    }

    /// The sum `a + b` represented as an implicit sum `head + tail`.
    ///
    /// This is a faster version of `sum(_:_:)` that requires the caller to
    /// guarantee that `large.magnitude >= small.magnitude`.
    ///
    /// This operation is sometimes called "fastTwoSum" or "fast2Sum".
    ///
    /// - Parameters:
    ///   - large: The summand with larger (or equal) magnitude.
    ///   - small: The summand with smaller (or equal) magnitude.
    /// - Returns: A tuple `(head, tail)` where `head` is the rounded sum
    ///   and `tail` is the rounding error.
    ///
    /// - Precondition: `large.magnitude >= small.magnitude`
    ///
    /// ## Performance
    ///
    /// This uses 3 floating-point operations versus 6 for `sum(_:_:)`.
    /// Use this when you know the relative magnitudes statically.
    ///
    /// ## Note
    ///
    /// For decimal floating-point types (radix != 2), this falls back to
    /// the general `sum(_:_:)` algorithm for correctness.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let big = 1e16
    /// let small = 1.0
    /// // We know big.magnitude > small.magnitude
    /// let (head, tail) = Numeric.Augmented.sum(large: big, small: small)
    /// ```
    @inlinable
    public static func sum<T: FloatingPoint>(
        large: T,
        small: T
    ) -> (head: T, tail: T) {
        // Fall back on 2Sum if radix != 2 (e.g., decimal floating-point)
        guard T.radix == 2 else { return sum(large, small) }
        // Fast2Sum: only works for binary floating-point
        let head = large + small
        let tail = large - head + small
        return (head, tail)
    }
}
