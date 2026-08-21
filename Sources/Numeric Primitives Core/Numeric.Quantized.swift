extension Numeric {

    public protocol Quantized {
        associatedtype Scalar: BinaryFloatingPoint

        static var quantum: Scalar { get }
    }
}

extension Numeric.Quantized {

    @inlinable
    public static func quantize(_ value: Scalar) -> Scalar {
        let ticks = Int64((value / quantum).rounded())
        return Scalar(ticks) * quantum
    }

    @inlinable
    public static func quantum<T: BinaryFloatingPoint>(as type: T.Type) -> T {
        T(quantum)
    }
}
