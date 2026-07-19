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
    /// Rotation is performed on the value's unsigned bit pattern
    /// (`T.Magnitude`) using logical shifts. `T`'s own `>>`/`<<` operators
    /// are not used directly here: for a signed `FixedWidthInteger`, `>>` is
    /// an arithmetic (sign-extending) shift, which would replicate the sign
    /// bit into positions that must instead receive the bits that fell off
    /// the opposite end — silently corrupting the rotation for negative
    /// values (F-001).
    ///
    /// - Parameter count: The number of bit positions to rotate.
    /// - Returns: The rotated value.
    @inlinable
    public func right(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        let bits = T.Magnitude(truncatingIfNeeded: value)
        let rotated = (bits >> effectiveCount) | (bits << (T.bitWidth - effectiveCount))
        return T(truncatingIfNeeded: rotated)
    }

    /// Rotates bits to the left by the specified amount.
    ///
    /// Bits that fall off the left end wrap around to the right.
    ///
    /// Rotation is performed on the value's unsigned bit pattern
    /// (`T.Magnitude`) using logical shifts, for the same reason described
    /// on `right(by:)` (F-001).
    ///
    /// - Parameter count: The number of bit positions to rotate.
    /// - Returns: The rotated value.
    @inlinable
    public func left(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        let bits = T.Magnitude(truncatingIfNeeded: value)
        let rotated = (bits << effectiveCount) | (bits >> (T.bitWidth - effectiveCount))
        return T(truncatingIfNeeded: rotated)
    }
}
