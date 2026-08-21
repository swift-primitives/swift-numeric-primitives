public import Numeric_Primitives_Core
public import Numeric_Shims

extension Numeric {

    public enum Relaxed {}
}

extension Numeric.Relaxed {

    @inlinable
    public static func sum(_ a: Double, _ b: Double) -> Double {
        shim_relaxed_add(a, b)
    }

    @inlinable
    public static func product(_ a: Double, _ b: Double) -> Double {
        shim_relaxed_mul(a, b)
    }

    @inlinable
    public static func multiplyAdd(_ a: Double, _ b: Double, _ c: Double) -> Double {
        shim_relaxed_add(c, shim_relaxed_mul(a, b))
    }
}

extension Numeric.Relaxed {

    @inlinable
    public static func sum(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_addf(a, b)
    }

    @inlinable
    public static func product(_ a: Float, _ b: Float) -> Float {
        shim_relaxed_mulf(a, b)
    }

    @inlinable
    public static func multiplyAdd(_ a: Float, _ b: Float, _ c: Float) -> Float {
        shim_relaxed_addf(c, shim_relaxed_mulf(a, b))
    }
}
