extension Numeric.Integer {

    public struct Division<T: SignedInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Division: Sendable where T: Sendable {}

extension Numeric.Integer.Division {

    @inlinable
    public func callAsFunction(by divisor: T, rounding: Numeric.Rounding = .down) -> T {
        switch rounding {
        case .direction(.down):

            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 && (value < 0) != (divisor < 0) {
                return q - 1
            }
            return q

        case .direction(.up):

            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 && (value < 0) == (divisor < 0) {
                return q + 1
            }
            return q

        case .direction(.zero):

            return value / divisor

        case .direction(.away):

            let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
            if r != 0 {
                return q < 0 ? q - 1 : q + 1
            }
            return q

        case .nearest(let tie):
            return divideToNearest(by: divisor, tieBreaker: tie)

        case .odd, .exact:

            return value / divisor
        }
    }

    @inlinable
    public func parts(
        by divisor: T,
        rounding: Numeric.Rounding = .down
    ) -> (quotient: T, remainder: T) {
        let q = self.callAsFunction(by: divisor, rounding: rounding)
        let r = value - q * divisor
        return (q, r)
    }

    @usableFromInline
    internal func divideToNearest(by divisor: T, tieBreaker: Numeric.Rounding.Nearest) -> T {
        let (q, r) = value.quotientAndRemainder(dividingBy: divisor)
        let absR = r < 0 ? -r : r
        let absD = divisor < 0 ? -divisor : divisor
        let doubled = absR * 2

        if doubled < absD {
            return q
        } else if doubled > absD {
            return (value < 0) != (divisor < 0) ? q - 1 : q + 1
        } else {

            switch tieBreaker {
            case .down:
                return (value < 0) != (divisor < 0) ? q - 1 : q

            case .up:
                return (value < 0) == (divisor < 0) ? q + 1 : q

            case .zero:
                return q

            case .away:
                return (value < 0) != (divisor < 0) ? q - 1 : q + 1

            case .even:
                return q % 2 == 0 ? q : ((value < 0) != (divisor < 0) ? q - 1 : q + 1)
            }
        }
    }
}
