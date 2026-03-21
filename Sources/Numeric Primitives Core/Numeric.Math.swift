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
    /// Math namespace for mathematical operations.
    ///
    /// The `Math` enum serves as a namespace for:
    /// - Elementary functions (exp, log, sin, cos, etc.) via C shims in Real Primitives
    /// - The `Accessor` struct for type-safe function dispatch
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Access via type's math property
    /// let y = Double.math.exp(1.0)  // e ≈ 2.718...
    /// let z = Double.math.sin(.pi / 2)  // 1.0
    /// ```
    public enum Math {}
}
