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

extension FixedWidthInteger where Self: Sendable {
    /// Access saturating arithmetic operations.
    ///
    /// ```swift
    /// let result = Int8.max.saturating.add(10)     // 127 (clamped)
    /// let diff = Int8.min.saturating.subtract(10)  // -128 (clamped)
    /// ```
    @inlinable
    public var saturating: Numeric.Integer.Saturating<Self> {
        Numeric.Integer.Saturating(self)
    }
}
