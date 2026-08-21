import Numeric_Primitives_Core

extension Numeric.Integer {

    public struct Shift<T: BinaryInteger> {
        @usableFromInline
        let value: T

        @usableFromInline
        internal init(_ value: T) {
            self.value = value
        }
    }
}

extension Numeric.Integer.Shift: Sendable where T: Sendable {
}

extension Numeric.Integer.Shift {

    @inlinable
    public func right(
        by count: Int,
        rounding rule: Numeric.Rounding = .down
    ) -> T {

        if count <= 0 { return value >> count }

        if count >= value.bitWidth {

            if value.bitWidth <= 1 {
                return T(Int8(value).shifted.right(by: count, rounding: rule))
            }

            let shiftCount = count - (value.bitWidth - 1)
            let floor = value >> shiftCount
            let lost = value - (floor << shiftCount)
            let sticky = floor | (lost == 0 ? 0 : 1)
            return sticky.shifted.right(by: value.bitWidth - 1, rounding: rule)
        }

        let mask = (T.Magnitude(1) << count) - 1
        let lost = T.Magnitude(truncatingIfNeeded: value) & mask
        let floor = value >> count
        let ceiling = floor + (lost == 0 ? 0 : 1)
        let half: T.Magnitude = (1 as T.Magnitude) << (count &- 1)

        switch rule {
        case .direction(.down):
            return floor

        case .direction(.up):
            return ceiling

        case .direction(.zero):
            return value > 0 ? floor : ceiling

        case .direction(.away):
            return value < 0 ? floor : ceiling

        case .nearest(.down):
            return floor + T((lost + (half - 1)) >> count)

        case .nearest(.up):
            return floor + T((lost + half) >> count)

        case .nearest(.zero):
            let round = half - (value < 0 ? 0 : 1)
            return floor + T((round + lost) >> count)

        case .nearest(.away):
            let round = half - (value > 0 ? 0 : 1)
            return floor + T((round + lost) >> count)

        case .nearest(.even):
            let round = mask >> 1 + T.Magnitude(floor & 1)
            return floor + T((round + lost) >> count)

        case .odd:
            return floor | (lost == 0 ? 0 : 1)

        case .exact:
            precondition(lost == 0, "shift was not exact.")
            return floor
        }
    }

    @inlinable @inline(always)
    public func right<Count: BinaryInteger>(
        by count: Count,
        rounding rule: Numeric.Rounding = .down
    ) -> T {
        self.right(by: Int(clamping: count), rounding: rule)
    }
}
