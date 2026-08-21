extension Numeric.Comparison {

    public struct Equals<T> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Comparison.Equals: Sendable where T: Sendable {}

extension Numeric.Comparison.Equals where T: FloatingPoint {

    @inlinable
    public func approximate(_ other: T, tolerance: T) -> Bool {
        (value - other).magnitude <= tolerance
    }

    @inlinable
    public func approximate(_ other: T, absolute: T, relative: T = .zero) -> Bool {
        let diff = (value - other).magnitude
        let scale = Swift.max(value.magnitude, other.magnitude)
        return diff <= absolute + relative * scale
    }
}

extension Numeric.Comparison.Equals where T: SignedNumeric, T.Magnitude: Comparable {

    @inlinable
    public func approximate(_ other: T, tolerance: T.Magnitude) -> Bool {
        (value - other).magnitude <= tolerance
    }
}

extension FloatingPoint where Self: Sendable {

    @inlinable
    public var equals: Numeric.Comparison.Equals<Self> {
        Numeric.Comparison.Equals(self)
    }
}

extension SignedNumeric where Self: Sendable {

    @inlinable
    public var equals: Numeric.Comparison.Equals<Self> {
        Numeric.Comparison.Equals(self)
    }
}
