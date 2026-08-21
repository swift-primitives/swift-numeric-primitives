extension FloatingPoint {

    @inlinable @inline(always)
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

            let nearest = rounded(.toNearestOrEven)
            return nearest - self == 1 / 2 ? rounded(.down) : nearest

        case .nearest(.up):

            let nearest = rounded(.toNearestOrEven)
            return self - nearest == 1 / 2 ? rounded(.up) : nearest

        case .nearest(.zero):

            let nearest = rounded(.toNearestOrEven)
            return (self - nearest).magnitude == 1 / 2 ? rounded(.towardZero) : nearest

        case .nearest(.away):
            return rounded(.toNearestOrAwayFromZero)

        case .nearest(.even):
            return rounded(.toNearestOrEven)

        case .odd:
            let trunc = rounded(.towardZero)
            if trunc == self { return trunc }
            let one = Self(signOf: self, magnitudeOf: 1)

            let even = (trunc + one / 2).rounded(.toNearestOrEven)
            return trunc == even ? trunc + one : trunc

        case .exact:
            let trunc = rounded(.towardZero)
            precondition(isInfinite || trunc == self, "\(self) is not an exact integer.")
            return self
        }
    }
}
