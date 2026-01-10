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
    /// Namespace for integer-specific operations and utilities.
    ///
    /// Provides GCD computation, division with rounding, bit rotation,
    /// and saturating arithmetic.
    ///
    /// ```swift
    /// let g = Numeric.Integer.gcd(24, 36)  // 12
    ///
    /// let q = 17.division(by: 5)           // 3 (floor)
    /// let (q, r) = 17.division.parts(by: 5) // (3, 2)
    ///
    /// let rotated = value.rotation.right(by: 3)
    /// let saturated = value.saturating.add(other)
    /// ```
    public typealias Integer = Int
}
