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

extension SignedInteger where Self: Sendable {
    /// Access division operations with rounding control.
    ///
    /// ```swift
    /// let q = 17.division(by: 5)              // 3 (floor)
    /// let q = (-17).division(by: 5)           // -4 (floor)
    /// let (q, r) = 17.division.parts(by: 5)   // (3, 2)
    /// ```
    @inlinable
    public var division: Numeric.Integer.Division<Self> {
        Numeric.Integer.Division(self)
    }
}
