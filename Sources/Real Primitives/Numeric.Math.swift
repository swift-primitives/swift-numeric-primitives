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

public import Numeric_Primitives_Core
import _Shims

// MARK: - Float

extension Numeric.Math {
    @usableFromInline
    internal static func exp(_ x: Float) -> Float { shim_expf(x) }

    @usableFromInline
    internal static func expm1(_ x: Float) -> Float { shim_expm1f(x) }

    @usableFromInline
    internal static func log(_ x: Float) -> Float { shim_logf(x) }

    @usableFromInline
    internal static func log1p(_ x: Float) -> Float { shim_log1pf(x) }

    @usableFromInline
    internal static func log2(_ x: Float) -> Float { shim_log2f(x) }

    @usableFromInline
    internal static func log10(_ x: Float) -> Float { shim_log10f(x) }

    @usableFromInline
    internal static func sin(_ x: Float) -> Float { shim_sinf(x) }

    @usableFromInline
    internal static func cos(_ x: Float) -> Float { shim_cosf(x) }

    @usableFromInline
    internal static func tan(_ x: Float) -> Float { shim_tanf(x) }

    @usableFromInline
    internal static func asin(_ x: Float) -> Float { shim_asinf(x) }

    @usableFromInline
    internal static func acos(_ x: Float) -> Float { shim_acosf(x) }

    @usableFromInline
    internal static func atan(_ x: Float) -> Float { shim_atanf(x) }

    @usableFromInline
    internal static func atan2(_ y: Float, _ x: Float) -> Float { shim_atan2f(y, x) }

    @usableFromInline
    internal static func sinh(_ x: Float) -> Float { shim_sinhf(x) }

    @usableFromInline
    internal static func cosh(_ x: Float) -> Float { shim_coshf(x) }

    @usableFromInline
    internal static func tanh(_ x: Float) -> Float { shim_tanhf(x) }

    @usableFromInline
    internal static func asinh(_ x: Float) -> Float { shim_asinhf(x) }

    @usableFromInline
    internal static func acosh(_ x: Float) -> Float { shim_acoshf(x) }

    @usableFromInline
    internal static func atanh(_ x: Float) -> Float { shim_atanhf(x) }

    @usableFromInline
    internal static func pow(_ x: Float, _ y: Float) -> Float { shim_powf(x, y) }

    @usableFromInline
    internal static func sqrt(_ x: Float) -> Float { x.squareRoot() }

    @usableFromInline
    internal static func cbrt(_ x: Float) -> Float { shim_cbrtf(x) }

    @usableFromInline
    internal static func root(_ x: Float, _ n: Int) -> Float {
        // Negative x with even n has no real root
        guard x >= 0 || n % 2 != 0 else { return .nan }
        // Use cbrt for n == 3 for better accuracy
        if n == 3 { return shim_cbrtf(x) }
        // General case: sign(x) * |x|^(1/n)
        return Float(signOf: x, magnitudeOf: shim_powf(x.magnitude, 1 / Float(n)))
    }

    @usableFromInline
    internal static func hypot(_ x: Float, _ y: Float) -> Float { shim_hypotf(x, y) }

    @usableFromInline
    internal static func exp2(_ x: Float) -> Float { shim_exp2f(x) }

    @usableFromInline
    internal static func erf(_ x: Float) -> Float { shim_erff(x) }

    @usableFromInline
    internal static func erfc(_ x: Float) -> Float { shim_erfcf(x) }

    @usableFromInline
    internal static func tgamma(_ x: Float) -> Float { shim_tgammaf(x) }
}

// MARK: - Double

extension Numeric.Math {
    @usableFromInline
    internal static func exp(_ x: Double) -> Double { shim_exp(x) }

    @usableFromInline
    internal static func expm1(_ x: Double) -> Double { shim_expm1(x) }

    @usableFromInline
    internal static func log(_ x: Double) -> Double { shim_log(x) }

    @usableFromInline
    internal static func log1p(_ x: Double) -> Double { shim_log1p(x) }

    @usableFromInline
    internal static func log2(_ x: Double) -> Double { shim_log2(x) }

    @usableFromInline
    internal static func log10(_ x: Double) -> Double { shim_log10(x) }

    @usableFromInline
    internal static func sin(_ x: Double) -> Double { shim_sin(x) }

    @usableFromInline
    internal static func cos(_ x: Double) -> Double { shim_cos(x) }

    @usableFromInline
    internal static func tan(_ x: Double) -> Double { shim_tan(x) }

    @usableFromInline
    internal static func asin(_ x: Double) -> Double { shim_asin(x) }

    @usableFromInline
    internal static func acos(_ x: Double) -> Double { shim_acos(x) }

    @usableFromInline
    internal static func atan(_ x: Double) -> Double { shim_atan(x) }

    @usableFromInline
    internal static func atan2(_ y: Double, _ x: Double) -> Double { shim_atan2(y, x) }

    @usableFromInline
    internal static func sinh(_ x: Double) -> Double { shim_sinh(x) }

    @usableFromInline
    internal static func cosh(_ x: Double) -> Double { shim_cosh(x) }

    @usableFromInline
    internal static func tanh(_ x: Double) -> Double { shim_tanh(x) }

    @usableFromInline
    internal static func asinh(_ x: Double) -> Double { shim_asinh(x) }

    @usableFromInline
    internal static func acosh(_ x: Double) -> Double { shim_acosh(x) }

    @usableFromInline
    internal static func atanh(_ x: Double) -> Double { shim_atanh(x) }

    @usableFromInline
    internal static func pow(_ x: Double, _ y: Double) -> Double { shim_pow(x, y) }

    @usableFromInline
    internal static func sqrt(_ x: Double) -> Double { x.squareRoot() }

    @usableFromInline
    internal static func cbrt(_ x: Double) -> Double { shim_cbrt(x) }

    @usableFromInline
    internal static func root(_ x: Double, _ n: Int) -> Double {
        // Negative x with even n has no real root
        guard x >= 0 || n % 2 != 0 else { return .nan }
        // Use cbrt for n == 3 for better accuracy
        if n == 3 { return shim_cbrt(x) }
        // General case: sign(x) * |x|^(1/n)
        return Double(signOf: x, magnitudeOf: shim_pow(x.magnitude, 1 / Double(n)))
    }

    @usableFromInline
    internal static func hypot(_ x: Double, _ y: Double) -> Double { shim_hypot(x, y) }

    @usableFromInline
    internal static func exp2(_ x: Double) -> Double { shim_exp2(x) }

    @usableFromInline
    internal static func erf(_ x: Double) -> Double { shim_erf(x) }

    @usableFromInline
    internal static func erfc(_ x: Double) -> Double { shim_erfc(x) }

    @usableFromInline
    internal static func tgamma(_ x: Double) -> Double { shim_tgamma(x) }
}

// MARK: - Float16

// swiftlint:disable:next l1_no_platform_conditionals - reason: Float16 libm shims (shim_expf etc.) resolve only on the listed platform/arch combinations; the extension cannot compile where Float16 hardware math is absent.
#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
    extension Numeric.Math {
        @usableFromInline
        internal static func exp(_ x: Float16) -> Float16 { Float16(shim_expf(Float(x))) }

        @usableFromInline
        internal static func expm1(_ x: Float16) -> Float16 { Float16(shim_expm1f(Float(x))) }

        @usableFromInline
        internal static func log(_ x: Float16) -> Float16 { Float16(shim_logf(Float(x))) }

        @usableFromInline
        internal static func log1p(_ x: Float16) -> Float16 { Float16(shim_log1pf(Float(x))) }

        @usableFromInline
        internal static func log2(_ x: Float16) -> Float16 { Float16(shim_log2f(Float(x))) }

        @usableFromInline
        internal static func log10(_ x: Float16) -> Float16 { Float16(shim_log10f(Float(x))) }

        @usableFromInline
        internal static func sin(_ x: Float16) -> Float16 { Float16(shim_sinf(Float(x))) }

        @usableFromInline
        internal static func cos(_ x: Float16) -> Float16 { Float16(shim_cosf(Float(x))) }

        @usableFromInline
        internal static func tan(_ x: Float16) -> Float16 { Float16(shim_tanf(Float(x))) }

        @usableFromInline
        internal static func asin(_ x: Float16) -> Float16 { Float16(shim_asinf(Float(x))) }

        @usableFromInline
        internal static func acos(_ x: Float16) -> Float16 { Float16(shim_acosf(Float(x))) }

        @usableFromInline
        internal static func atan(_ x: Float16) -> Float16 { Float16(shim_atanf(Float(x))) }

        @usableFromInline
        internal static func atan2(_ y: Float16, _ x: Float16) -> Float16 { Float16(shim_atan2f(Float(y), Float(x))) }

        @usableFromInline
        internal static func sinh(_ x: Float16) -> Float16 { Float16(shim_sinhf(Float(x))) }

        @usableFromInline
        internal static func cosh(_ x: Float16) -> Float16 { Float16(shim_coshf(Float(x))) }

        @usableFromInline
        internal static func tanh(_ x: Float16) -> Float16 { Float16(shim_tanhf(Float(x))) }

        @usableFromInline
        internal static func asinh(_ x: Float16) -> Float16 { Float16(shim_asinhf(Float(x))) }

        @usableFromInline
        internal static func acosh(_ x: Float16) -> Float16 { Float16(shim_acoshf(Float(x))) }

        @usableFromInline
        internal static func atanh(_ x: Float16) -> Float16 { Float16(shim_atanhf(Float(x))) }

        @usableFromInline
        internal static func pow(_ x: Float16, _ y: Float16) -> Float16 { Float16(shim_powf(Float(x), Float(y))) }

        @usableFromInline
        internal static func sqrt(_ x: Float16) -> Float16 { x.squareRoot() }

        @usableFromInline
        internal static func cbrt(_ x: Float16) -> Float16 { Float16(shim_cbrtf(Float(x))) }

        @usableFromInline
        internal static func root(_ x: Float16, _ n: Int) -> Float16 {
            guard x >= 0 || n % 2 != 0 else { return .nan }
            if n == 3 { return Float16(shim_cbrtf(Float(x))) }
            return Float16(signOf: x, magnitudeOf: Float16(shim_powf(Float(x.magnitude), 1 / Float(n))))
        }

        @usableFromInline
        internal static func hypot(_ x: Float16, _ y: Float16) -> Float16 { Float16(shim_hypotf(Float(x), Float(y))) }

        @usableFromInline
        internal static func exp2(_ x: Float16) -> Float16 { Float16(shim_exp2f(Float(x))) }

        @usableFromInline
        internal static func erf(_ x: Float16) -> Float16 { Float16(shim_erff(Float(x))) }

        @usableFromInline
        internal static func erfc(_ x: Float16) -> Float16 { Float16(shim_erfcf(Float(x))) }

        @usableFromInline
        internal static func tgamma(_ x: Float16) -> Float16 { Float16(shim_tgammaf(Float(x))) }
    }
#endif
