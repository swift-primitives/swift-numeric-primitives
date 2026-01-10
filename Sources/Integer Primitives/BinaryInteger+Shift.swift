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

import Numeric_Primitives

extension BinaryInteger {
    /// Accessor for shift operations with rounding.
    @inlinable
    public var shifted: Numeric.Integer.Shift<Self> {
        Numeric.Integer.Shift(self)
    }
}
