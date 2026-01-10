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
    /// Access bit rotation operations.
    ///
    /// ```swift
    /// let rotated = value.rotation.right(by: 3)
    /// let shifted = value.rotation.left(by: 5)
    /// ```
    @inlinable
    public var rotation: Numeric.Integer.Rotation<Self> {
        Numeric.Integer.Rotation(self)
    }
}
