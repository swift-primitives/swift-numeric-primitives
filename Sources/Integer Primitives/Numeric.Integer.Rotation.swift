extension Numeric.Integer {

    public struct Rotation<T: FixedWidthInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Rotation: Sendable where T: Sendable {}

extension Numeric.Integer.Rotation {

    @inlinable
    public func right(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        let bits = T.Magnitude(truncatingIfNeeded: value)
        let rotated = (bits >> effectiveCount) | (bits << (T.bitWidth - effectiveCount))
        return T(truncatingIfNeeded: rotated)
    }

    @inlinable
    public func left(by count: Int) -> T {
        let effectiveCount = count & (T.bitWidth - 1)
        guard effectiveCount != 0 else { return value }
        let bits = T.Magnitude(truncatingIfNeeded: value)
        let rotated = (bits << effectiveCount) | (bits >> (T.bitWidth - effectiveCount))
        return T(truncatingIfNeeded: rotated)
    }
}
