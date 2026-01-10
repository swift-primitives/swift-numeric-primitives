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
    /// Accessor struct for saturating arithmetic operations.
    ///
    /// Saturating operations clamp results to the representable range
    /// instead of overflowing.
    ///
    /// ```swift
    /// let result = Int8.max.saturating.add(10)  // 127 (clamped)
    /// let diff = Int8.min.saturating.subtract(10)  // -128 (clamped)
    /// ```
    public struct Saturating<T: FixedWidthInteger>: Sendable where T: Sendable {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

// MARK: - Saturating Operations

extension Numeric.Integer.Saturating {
    /// Adds with saturation (clamps on overflow).
    @inlinable
    public func add(_ other: T) -> T {
        let (result, overflow) = value.addingReportingOverflow(other)
        if overflow {
            return other > 0 ? T.max : T.min
        }
        return result
    }

    /// Subtracts with saturation (clamps on overflow).
    @inlinable
    public func subtract(_ other: T) -> T {
        let (result, overflow) = value.subtractingReportingOverflow(other)
        if overflow {
            return other > 0 ? T.min : T.max
        }
        return result
    }

    /// Multiplies with saturation (clamps on overflow).
    @inlinable
    public func multiply(by other: T) -> T {
        let (result, overflow) = value.multipliedReportingOverflow(by: other)
        if overflow {
            // Determine sign of result
            let sameSign = (value >= 0) == (other >= 0)
            return sameSign ? T.max : T.min
        }
        return result
    }

    /// Negates with saturation (clamps on overflow).
    @inlinable
    public func negate() -> T where T: SignedInteger {
        if value == T.min {
            return T.max
        }
        return -value
    }
}
