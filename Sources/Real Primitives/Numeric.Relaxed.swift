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
    /// Arithmetic operations with relaxed floating-point semantics.
    ///
    /// Relaxed arithmetic grants the optimizer permission to reassociate
    /// expressions and form fused multiply-add (FMA) operations. This can
    /// provide significant performance improvements for loops and reductions.
    ///
    /// ## Overview
    ///
    /// Floating-point addition and multiplication are not associative, so the
    /// Swift compiler must evaluate expressions in the exact order written.
    /// This prevents optimizations like loop unrolling and vectorization.
    ///
    /// Using `Numeric.Relaxed.sum` instead of `+` permits the compiler to
    /// reorder terms, which can unlock ~8x speedups for array reductions.
    ///
    /// ## Important
    ///
    /// Relaxed operations may produce slightly different results than strict
    /// operations due to reassociation. The results are still accurate within
    /// floating-point error bounds, but may not be bit-identical.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Strict summation (sequential, not vectorizable)
    /// let strictSum = array.reduce(0.0, +)
    ///
    /// // Relaxed summation (can be vectorized)
    /// let relaxedSum = array.reduce(0.0, Numeric.Relaxed.sum)
    ///
    /// // Relaxed sum of squares (can form FMAs)
    /// let sumOfSquares = array.reduce(0.0) {
    ///     Numeric.Relaxed.multiplyAdd($1, $1, $0)
    /// }
    /// ```
    public enum Relaxed {}
}

// MARK: - Sum

extension Numeric.Relaxed {
    /// `a + b`, with the optimizer permitted to reassociate and form FMAs.
    ///
    /// This is semantically equivalent to `a + b`, but grants the compiler
    /// permission to reorder this operation relative to other relaxed
    /// operations, enabling vectorization and loop unrolling.
    ///
    /// - Parameters:
    ///   - a: First summand.
    ///   - b: Second summand.
    /// - Returns: The sum `a + b`, possibly computed in a different order
    ///   than written if combined with other relaxed operations.
    ///
    /// ## Note
    ///
    /// If you want to compute `a - b` with relaxed semantics, use
    /// `Numeric.Relaxed.sum(a, -b)`.
    ///
    /// ## Fallback
    ///
    /// On platforms that don't support relaxed floating-point, this decays
    /// to a normal addition.
    @inlinable
    public static func sum<T: Numeric.Real>(_ a: T, _ b: T) -> T {
        T._relaxedAdd(a, b)
    }
}

// MARK: - Product

extension Numeric.Relaxed {
    /// `a * b`, with the optimizer permitted to reassociate and form FMAs.
    ///
    /// This is semantically equivalent to `a * b`, but grants the compiler
    /// permission to reorder this operation relative to other relaxed
    /// operations, and to fuse it with adjacent additions into FMAs.
    ///
    /// - Parameters:
    ///   - a: First multiplicand.
    ///   - b: Second multiplicand.
    /// - Returns: The product `a * b`, possibly fused with other operations.
    ///
    /// ## Fallback
    ///
    /// On platforms that don't support relaxed floating-point, this decays
    /// to a normal multiplication.
    @inlinable
    public static func product<T: Numeric.Real>(_ a: T, _ b: T) -> T {
        T._relaxedMul(a, b)
    }
}

// MARK: - Multiply-Add

extension Numeric.Relaxed {
    /// `a * b + c`, computed either as FMA or separate operations.
    ///
    /// The optimizer may compute this as a fused multiply-add (FMA) or as
    /// separate multiply and add, whichever is faster on the target platform.
    ///
    /// - Parameters:
    ///   - a: First multiplicand.
    ///   - b: Second multiplicand.
    ///   - c: Addend.
    /// - Returns: `a * b + c`, possibly as an FMA.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Sum of squares using relaxed multiply-add
    /// let sumOfSquares = array.reduce(0.0) {
    ///     Numeric.Relaxed.multiplyAdd($1, $1, $0)
    /// }
    /// ```
    @inlinable
    public static func multiplyAdd<T: Numeric.Real>(
        _ a: T,
        _ b: T,
        _ c: T
    ) -> T {
        T._relaxedAdd(c, T._relaxedMul(a, b))
    }
}
