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

public import Numeric_Primitives

// MARK: - Double Conformance

extension Double: Numeric.Transcendental {
    @inlinable public static func _sin(_ x: Double) -> Double { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Double) -> Double { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Double) -> Double { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Double) -> Double { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Double) -> Double { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Double) -> Double { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Double, _ x: Double) -> Double { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Double) -> Double { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Double) -> Double { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Double) -> Double { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Double) -> Double { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Double) -> Double { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Double) -> Double { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Double) -> Double { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Double) -> Double { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Double) -> Double { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Double) -> Double { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Double) -> Double { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Double) -> Double { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Double) -> Double { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Double, _ y: Double) -> Double { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Double) -> Double { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Double) -> Double { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Double, _ y: Double) -> Double { Numeric.Math.hypot(x, y) }
}

// MARK: - Float Conformance

extension Float: Numeric.Transcendental {
    @inlinable public static func _sin(_ x: Float) -> Float { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Float) -> Float { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Float) -> Float { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Float) -> Float { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Float) -> Float { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Float) -> Float { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Float, _ x: Float) -> Float { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Float) -> Float { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Float) -> Float { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Float) -> Float { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Float) -> Float { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Float) -> Float { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Float) -> Float { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Float) -> Float { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Float) -> Float { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Float) -> Float { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Float) -> Float { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Float) -> Float { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Float) -> Float { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Float) -> Float { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Float, _ y: Float) -> Float { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Float) -> Float { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Float) -> Float { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }
}

// MARK: - Float16 Conformance (Platform-Conditional)

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
extension Float16: Numeric.Transcendental {
    @inlinable public static func _sin(_ x: Float16) -> Float16 { Numeric.Math.sin(x) }
    @inlinable public static func _cos(_ x: Float16) -> Float16 { Numeric.Math.cos(x) }
    @inlinable public static func _tan(_ x: Float16) -> Float16 { Numeric.Math.tan(x) }
    @inlinable public static func _asin(_ x: Float16) -> Float16 { Numeric.Math.asin(x) }
    @inlinable public static func _acos(_ x: Float16) -> Float16 { Numeric.Math.acos(x) }
    @inlinable public static func _atan(_ x: Float16) -> Float16 { Numeric.Math.atan(x) }
    @inlinable public static func _atan2(_ y: Float16, _ x: Float16) -> Float16 { Numeric.Math.atan2(y, x) }
    @inlinable public static func _sinh(_ x: Float16) -> Float16 { Numeric.Math.sinh(x) }
    @inlinable public static func _cosh(_ x: Float16) -> Float16 { Numeric.Math.cosh(x) }
    @inlinable public static func _tanh(_ x: Float16) -> Float16 { Numeric.Math.tanh(x) }
    @inlinable public static func _asinh(_ x: Float16) -> Float16 { Numeric.Math.asinh(x) }
    @inlinable public static func _acosh(_ x: Float16) -> Float16 { Numeric.Math.acosh(x) }
    @inlinable public static func _atanh(_ x: Float16) -> Float16 { Numeric.Math.atanh(x) }
    @inlinable public static func _exp(_ x: Float16) -> Float16 { Numeric.Math.exp(x) }
    @inlinable public static func _expm1(_ x: Float16) -> Float16 { Numeric.Math.expm1(x) }
    @inlinable public static func _exp2(_ x: Float16) -> Float16 { Numeric.Math.exp2(x) }
    @inlinable public static func _log(_ x: Float16) -> Float16 { Numeric.Math.log(x) }
    @inlinable public static func _log1p(_ x: Float16) -> Float16 { Numeric.Math.log1p(x) }
    @inlinable public static func _log2(_ x: Float16) -> Float16 { Numeric.Math.log2(x) }
    @inlinable public static func _log10(_ x: Float16) -> Float16 { Numeric.Math.log10(x) }
    @inlinable public static func _pow(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.pow(x, y) }
    @inlinable public static func _sqrt(_ x: Float16) -> Float16 { Numeric.Math.sqrt(x) }
    @inlinable public static func _cbrt(_ x: Float16) -> Float16 { Numeric.Math.cbrt(x) }
    @inlinable public static func _hypot(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.hypot(x, y) }
}
#endif
