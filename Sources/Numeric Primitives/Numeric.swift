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

/// Numeric primitives: mathematical protocols and types.
///
/// `Numeric` serves as the root namespace for all numeric primitive types
/// and protocols, including:
/// - `Numeric.Real`: Protocol for real number types with elementary functions
/// - `Numeric.Complex`: Generic complex number type
/// - `Numeric.Rounding`: Rounding mode specification
/// - `Numeric.Approximate`: Approximate equality comparison
///
/// ## Example
///
/// ```swift
/// import Numeric_Primitives
///
/// // Use math operations via accessor
/// let y = Double.math.exp(1.0)  // e ≈ 2.718...
///
/// // Approximate equality
/// let x = 1.0 / 3.0 * 3.0
/// x.equals.approximate(1.0, tolerance: 1e-15)  // true
/// ```
public enum Numeric {
    public typealias `Protocol` = Swift.Numeric
    public typealias Transcendental = Numeric_Primitives.Transcendental
}
