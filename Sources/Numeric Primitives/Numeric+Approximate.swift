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

extension FloatingPoint where Self: Sendable {
    /// Access approximate equality comparisons.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let x = 1.0 / 3.0 * 3.0
    /// if x.approximate.equals(1.0, tolerance: 1e-15) {
    ///     print("Close enough!")
    /// }
    /// ```
    @inlinable
    public var approximate: Numeric.Comparison.Approximate<Self> {
        Numeric.Comparison.Approximate(self)
    }
}

extension SignedNumeric where Self: Sendable {
    /// Access approximate equality comparisons.
    @inlinable
    public var approximate: Numeric.Comparison.Approximate<Self> {
        Numeric.Comparison.Approximate(self)
    }
}
