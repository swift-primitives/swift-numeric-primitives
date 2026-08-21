public import Numeric_Primitives_Core

extension Double {

    @inlinable
    public static var math: Numeric.Math.Accessor<Double> { .init() }
}

extension Numeric.Math.Accessor where T == Double {

    @inlinable
    public func exp(_ x: Double) -> Double { Numeric.Math.exp(x) }

    @inlinable
    public func expm1(_ x: Double) -> Double { Numeric.Math.expm1(x) }

    @inlinable
    public func exp2(_ x: Double) -> Double { Numeric.Math.exp2(x) }

    @inlinable
    public func log(_ x: Double) -> Double { Numeric.Math.log(x) }

    @inlinable
    public func log1p(_ x: Double) -> Double { Numeric.Math.log1p(x) }

    @inlinable
    public func log2(_ x: Double) -> Double { Numeric.Math.log2(x) }

    @inlinable
    public func log10(_ x: Double) -> Double { Numeric.Math.log10(x) }

    @inlinable
    public func pow(_ x: Double, _ y: Double) -> Double { Numeric.Math.pow(x, y) }

    @inlinable
    public func sqrt(_ x: Double) -> Double { Numeric.Math.sqrt(x) }

    @inlinable
    public func cbrt(_ x: Double) -> Double { Numeric.Math.cbrt(x) }

    @inlinable
    public func hypot(_ x: Double, _ y: Double) -> Double { Numeric.Math.hypot(x, y) }

    @inlinable
    public func root(_ x: Double, _ n: Int) -> Double { Numeric.Math.root(x, n) }

    @inlinable
    public func sin(_ x: Double) -> Double { Numeric.Math.sin(x) }

    @inlinable
    public func cos(_ x: Double) -> Double { Numeric.Math.cos(x) }

    @inlinable
    public func tan(_ x: Double) -> Double { Numeric.Math.tan(x) }

    @inlinable
    public func asin(_ x: Double) -> Double { Numeric.Math.asin(x) }

    @inlinable
    public func acos(_ x: Double) -> Double { Numeric.Math.acos(x) }

    @inlinable
    public func atan(_ x: Double) -> Double { Numeric.Math.atan(x) }

    @inlinable
    public func atan2(_ y: Double, _ x: Double) -> Double { Numeric.Math.atan2(y, x) }

    @inlinable
    public func sinh(_ x: Double) -> Double { Numeric.Math.sinh(x) }

    @inlinable
    public func cosh(_ x: Double) -> Double { Numeric.Math.cosh(x) }

    @inlinable
    public func tanh(_ x: Double) -> Double { Numeric.Math.tanh(x) }

    @inlinable
    public func asinh(_ x: Double) -> Double { Numeric.Math.asinh(x) }

    @inlinable
    public func acosh(_ x: Double) -> Double { Numeric.Math.acosh(x) }

    @inlinable
    public func atanh(_ x: Double) -> Double { Numeric.Math.atanh(x) }

    @inlinable
    public func erf(_ x: Double) -> Double { Numeric.Math.erf(x) }

    @inlinable
    public func erfc(_ x: Double) -> Double { Numeric.Math.erfc(x) }

    @inlinable
    public func tgamma(_ x: Double) -> Double { Numeric.Math.tgamma(x) }

}

extension Float {

    @inlinable
    public static var math: Numeric.Math.Accessor<Float> { .init() }
}

extension Numeric.Math.Accessor where T == Float {

    @inlinable
    public func exp(_ x: Float) -> Float { Numeric.Math.exp(x) }

    @inlinable
    public func expm1(_ x: Float) -> Float { Numeric.Math.expm1(x) }

    @inlinable
    public func exp2(_ x: Float) -> Float { Numeric.Math.exp2(x) }

    @inlinable
    public func log(_ x: Float) -> Float { Numeric.Math.log(x) }

    @inlinable
    public func log1p(_ x: Float) -> Float { Numeric.Math.log1p(x) }

    @inlinable
    public func log2(_ x: Float) -> Float { Numeric.Math.log2(x) }

    @inlinable
    public func log10(_ x: Float) -> Float { Numeric.Math.log10(x) }

    @inlinable
    public func pow(_ x: Float, _ y: Float) -> Float { Numeric.Math.pow(x, y) }

    @inlinable
    public func sqrt(_ x: Float) -> Float { Numeric.Math.sqrt(x) }

    @inlinable
    public func cbrt(_ x: Float) -> Float { Numeric.Math.cbrt(x) }

    @inlinable
    public func hypot(_ x: Float, _ y: Float) -> Float { Numeric.Math.hypot(x, y) }

    @inlinable
    public func root(_ x: Float, _ n: Int) -> Float { Numeric.Math.root(x, n) }

    @inlinable
    public func sin(_ x: Float) -> Float { Numeric.Math.sin(x) }

    @inlinable
    public func cos(_ x: Float) -> Float { Numeric.Math.cos(x) }

    @inlinable
    public func tan(_ x: Float) -> Float { Numeric.Math.tan(x) }

    @inlinable
    public func asin(_ x: Float) -> Float { Numeric.Math.asin(x) }

    @inlinable
    public func acos(_ x: Float) -> Float { Numeric.Math.acos(x) }

    @inlinable
    public func atan(_ x: Float) -> Float { Numeric.Math.atan(x) }

    @inlinable
    public func atan2(_ y: Float, _ x: Float) -> Float { Numeric.Math.atan2(y, x) }

    @inlinable
    public func sinh(_ x: Float) -> Float { Numeric.Math.sinh(x) }

    @inlinable
    public func cosh(_ x: Float) -> Float { Numeric.Math.cosh(x) }

    @inlinable
    public func tanh(_ x: Float) -> Float { Numeric.Math.tanh(x) }

    @inlinable
    public func asinh(_ x: Float) -> Float { Numeric.Math.asinh(x) }

    @inlinable
    public func acosh(_ x: Float) -> Float { Numeric.Math.acosh(x) }

    @inlinable
    public func atanh(_ x: Float) -> Float { Numeric.Math.atanh(x) }

    @inlinable
    public func erf(_ x: Float) -> Float { Numeric.Math.erf(x) }

    @inlinable
    public func erfc(_ x: Float) -> Float { Numeric.Math.erfc(x) }

    @inlinable
    public func tgamma(_ x: Float) -> Float { Numeric.Math.tgamma(x) }

}

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS) || ((os(macOS) || targetEnvironment(macCatalyst)) && arch(arm64))
    extension Float16 {

        @inlinable
        public static var math: Numeric.Math.Accessor<Float16> { .init() }
    }

    extension Numeric.Math.Accessor where T == Float16 {

        @inlinable
        public func exp(_ x: Float16) -> Float16 { Numeric.Math.exp(x) }

        @inlinable
        public func expm1(_ x: Float16) -> Float16 { Numeric.Math.expm1(x) }

        @inlinable
        public func exp2(_ x: Float16) -> Float16 { Numeric.Math.exp2(x) }

        @inlinable
        public func log(_ x: Float16) -> Float16 { Numeric.Math.log(x) }

        @inlinable
        public func log1p(_ x: Float16) -> Float16 { Numeric.Math.log1p(x) }

        @inlinable
        public func log2(_ x: Float16) -> Float16 { Numeric.Math.log2(x) }

        @inlinable
        public func log10(_ x: Float16) -> Float16 { Numeric.Math.log10(x) }

        @inlinable
        public func pow(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.pow(x, y) }

        @inlinable
        public func sqrt(_ x: Float16) -> Float16 { Numeric.Math.sqrt(x) }

        @inlinable
        public func cbrt(_ x: Float16) -> Float16 { Numeric.Math.cbrt(x) }

        @inlinable
        public func root(_ x: Float16, _ n: Int) -> Float16 { Numeric.Math.root(x, n) }

        @inlinable
        public func hypot(_ x: Float16, _ y: Float16) -> Float16 { Numeric.Math.hypot(x, y) }

        @inlinable
        public func sin(_ x: Float16) -> Float16 { Numeric.Math.sin(x) }

        @inlinable
        public func cos(_ x: Float16) -> Float16 { Numeric.Math.cos(x) }

        @inlinable
        public func tan(_ x: Float16) -> Float16 { Numeric.Math.tan(x) }

        @inlinable
        public func asin(_ x: Float16) -> Float16 { Numeric.Math.asin(x) }

        @inlinable
        public func acos(_ x: Float16) -> Float16 { Numeric.Math.acos(x) }

        @inlinable
        public func atan(_ x: Float16) -> Float16 { Numeric.Math.atan(x) }

        @inlinable
        public func atan2(_ y: Float16, _ x: Float16) -> Float16 { Numeric.Math.atan2(y, x) }

        @inlinable
        public func sinh(_ x: Float16) -> Float16 { Numeric.Math.sinh(x) }

        @inlinable
        public func cosh(_ x: Float16) -> Float16 { Numeric.Math.cosh(x) }

        @inlinable
        public func tanh(_ x: Float16) -> Float16 { Numeric.Math.tanh(x) }

        @inlinable
        public func asinh(_ x: Float16) -> Float16 { Numeric.Math.asinh(x) }

        @inlinable
        public func acosh(_ x: Float16) -> Float16 { Numeric.Math.acosh(x) }

        @inlinable
        public func atanh(_ x: Float16) -> Float16 { Numeric.Math.atanh(x) }

        @inlinable
        public func erf(_ x: Float16) -> Float16 { Numeric.Math.erf(x) }

        @inlinable
        public func erfc(_ x: Float16) -> Float16 { Numeric.Math.erfc(x) }

        @inlinable
        public func tgamma(_ x: Float16) -> Float16 { Numeric.Math.tgamma(x) }

    }
#endif
