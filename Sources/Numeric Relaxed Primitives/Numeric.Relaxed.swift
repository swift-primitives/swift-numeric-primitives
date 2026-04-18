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

public import Numeric_Primitives_Core
public import _Shims

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

// MARK: - Double

extension Numeric.Relaxed {
    /// `a + b`, with the optimizer permitted to reassociate and form FMAs.
    @inlinable
    public static func sum(_ a: Double, _ b: Double) -> Double {
        shim_relaxed_add(a, b)
    }

    /// `a * b`, with the optimizer permitted to reassociate and form FMAs.
    @inlinable
    public static func product(_ a: Double, _ b: Double) -> Double {
        shim_relaxed_mul(a, b)
    }

    /// `a * b + c`, computed either as FMA or separate operations.
    @inlinable
    public static func multiplyAdd(_ a: Double, _ b: Double, _ c: Double) -> Double {
        shim_relaxed_add(c, shim_relaxed_mul(a, b))
    }
}

// MARK: - Float

extension Numeric.Relaxed {
    /// `a + b`, with the optimizer permitted to reassociate and form FMAs.
    @inlinable
    public static func sum(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_addf(a, b)
    }

    /// `a * b`, with the optimizer permitted to reassociate and form FMAs.
    @inlinable
    public static func product(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_mulf(a, b)
    }

    /// `a * b + c`, computed either as FMA or separate operations.
    @inlinable
    public static func multiplyAdd(_ a: Float, _ b: Float, _ c: Float) -> Float {
        shim_relaxed_addf(c, shim_relaxed_mulf(a, b))
    }
}
