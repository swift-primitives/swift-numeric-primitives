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
    /// A real number type with elementary mathematical functions.
    ///
    /// `Real` combines `FloatingPoint` with `Elementary`, providing both
    /// IEEE 754 floating-point semantics and elementary mathematical
    /// operations.
    ///
    /// ```swift
    /// func normalize<T: Numeric.Real>(_ v: (x: T, y: T)) -> (x: T, y: T) {
    ///     let length = T.math.hypot(v.x, v.y)
    ///     return (v.x / length, v.y / length)
    /// }
    /// ```
    ///
    /// Standard conformers: `Float`, `Double`, and on supported platforms,
    /// `Float16` and `Float80`.
    public protocol Real: Elementary {}
}
