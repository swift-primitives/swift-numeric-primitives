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

extension Numeric.Integer {
    /// Accessor struct for bit rotation operations.
    ///
    /// Access via the `.rotation` property on fixed-width integers:
    ///
    /// ```swift
    /// let rotated = value.rotation.right(by: 3)
    /// let shifted = value.rotation.left(by: 5)
    /// ```
    public struct Rotation<T: FixedWidthInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Rotation: Sendable where T: Sendable {}

// MARK: - Rotation Operations

extension Numeric.Integer.Rotation {
    /// Rotates bits to the right by the specified amount.
    ///
    /// Bits that fall off the right end wrap around to the left.
    ///
    /// - Parameter count: The number of bit positions to rotate.
    /// - Returns: The rotated value.
    @inlinable
    public func right(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        return (value >> effectiveCount) | (value << (T.bitWidth - effectiveCount))
    }

    /// Rotates bits to the left by the specified amount.
    ///
    /// Bits that fall off the left end wrap around to the right.
    ///
    /// - Parameter count: The number of bit positions to rotate.
    /// - Returns: The rotated value.
    @inlinable
    public func left(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        return (value << effectiveCount) | (value >> (T.bitWidth - effectiveCount))
    }
}
