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

extension Numeric.Math {
    /// Zero-sized accessor token for elementary math operations.
    ///
    /// The accessor pattern provides:
    /// - Zero runtime cost (empty struct)
    /// - Type-safe dispatch via constrained extensions
    /// - Clean call-site syntax: `Double.math.sin(x)`
    ///
    /// Concrete method implementations are added via extensions in Real Primitives,
    /// constrained to specific types (Double, Float, Float16).
    ///
    /// ## Example
    ///
    /// ```swift
    /// Double.math.exp(x)           // e^x
    /// Double.math.log(x)           // ln(x)
    /// Double.math.sin(x)           // sin(x)
    /// ```
    public struct Accessor<T>: Sendable {
        @usableFromInline
        package init() {}
    }
}
