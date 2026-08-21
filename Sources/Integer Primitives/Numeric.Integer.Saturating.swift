extension Numeric.Integer {

    public struct Saturating<T: FixedWidthInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Saturating: Sendable where T: Sendable {}

extension Numeric.Integer.Saturating {

    @inlinable
    public func add(_ other: T) -> T {
        let (result, overflow) = value.addingReportingOverflow(other)
        if overflow {
            return other > 0 ? T.max : T.min
        }
        return result
    }

    @inlinable
    public func subtract(_ other: T) -> T {
        let (result, overflow) = value.subtractingReportingOverflow(other)
        if overflow {
            return other > 0 ? T.min : T.max
        }
        return result
    }

    @inlinable
    public func multiply(by other: T) -> T {
        let (result, overflow) = value.multipliedReportingOverflow(by: other)
        if overflow {

            let sameSign = (value >= 0) == (other >= 0)
            return sameSign ? T.max : T.min
        }
        return result
    }

    @inlinable
    public func negate() -> T where T: SignedInteger {
        if value == T.min {
            return T.max
        }
        return -value
    }
}
