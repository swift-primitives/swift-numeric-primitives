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
    /// Computes the greatest common divisor of two integers.
    ///
    /// Uses the Euclidean algorithm. The result is always non-negative.
    ///
    /// ```swift
    /// Numeric.Integer.gcd(24, 36)   // 12
    /// Numeric.Integer.gcd(-15, 25)  // 5
    /// Numeric.Integer.gcd(0, 5)     // 5
    /// ```
    ///
    /// - Parameters:
    ///   - a: First integer.
    ///   - b: Second integer.
    /// - Returns: The greatest common divisor (always non-negative).
    @inlinable
    public static func gcd<T: BinaryInteger>(_ a: T, _ b: T) -> T {
        // Work with magnitudes to handle negative inputs
        var a = T(a.magnitude)
        var b = T(b.magnitude)

        while b != 0 {
            let t = b
            b = a % b
            a = t
        }
        return a
    }

    /// Computes the least common multiple of two integers.
    ///
    /// The result is always non-negative. Returns 0 if either input is 0.
    ///
    /// ```swift
    /// Numeric.Integer.lcm(4, 6)   // 12
    /// Numeric.Integer.lcm(3, 5)   // 15
    /// Numeric.Integer.lcm(0, 5)   // 0
    /// ```
    ///
    /// - Parameters:
    ///   - a: First integer.
    ///   - b: Second integer.
    /// - Returns: The least common multiple (always non-negative).
    @inlinable
    public static func lcm<T: BinaryInteger>(_ a: T, _ b: T) -> T {
        if a == 0 || b == 0 { return 0 }
        let absA = T(a.magnitude)
        let absB = T(b.magnitude)
        return absA / gcd(absA, absB) * absB
    }
}
