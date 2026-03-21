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

extension FloatingPoint {
    /// `self` rounded to integer according to `rule`.
    ///
    /// This extends the standard library `rounded` API with additional
    /// rounding modes from `Numeric.Rounding`.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// 2.5.rounding(.down)           // 2.0
    /// 2.5.rounding(.up)             // 3.0
    /// 2.5.rounding(.even)           // 2.0 (banker's rounding)
    /// 2.5.rounding(.nearest(.away)) // 3.0
    /// ```
    @inlinable @inline(__always)
    public func rounding(_ rule: Numeric.Rounding) -> Self {
        switch rule {
        case .direction(.down):
            return rounded(.down)

        case .direction(.up):
            return rounded(.up)

        case .direction(.zero):
            return rounded(.towardZero)

        case .direction(.away):
            return rounded(.awayFromZero)

        case .nearest(.down):
            // FP doesn't have toNearestOrDown, so round toNearestOrEven and fixup
            let nearest = rounded(.toNearestOrEven)
            return nearest - self == 1/2 ? rounded(.down) : nearest

        case .nearest(.up):
            // FP doesn't have toNearestOrUp, so round toNearestOrEven and fixup
            let nearest = rounded(.toNearestOrEven)
            return self - nearest == 1/2 ? rounded(.up) : nearest

        case .nearest(.zero):
            // FP doesn't have toNearestOrZero, so round toNearestOrEven and fixup
            let nearest = rounded(.toNearestOrEven)
            return (self - nearest).magnitude == 1/2 ? rounded(.towardZero) : nearest

        case .nearest(.away):
            return rounded(.toNearestOrAwayFromZero)

        case .nearest(.even):
            return rounded(.toNearestOrEven)

        case .odd:
            let trunc = rounded(.towardZero)
            if trunc == self { return trunc }
            let one = Self(signOf: self, magnitudeOf: 1)
            // Add ±0.5 and see which way that rounds, then select the other value
            let even = (trunc + one/2).rounded(.toNearestOrEven)
            return trunc == even ? trunc + one : trunc

        case .exact:
            let trunc = rounded(.towardZero)
            precondition(isInfinite || trunc == self, "\(self) is not an exact integer.")
            return self
        }
    }
}
