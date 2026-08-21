extension Numeric {

    public struct Fraction<let Numerator: Int, let Denominator: Int, Result> {

        public let value: Result

        @inlinable
        public init(_ value: Result) {
            self.value = value
        }

        @inlinable
        public func callAsFunction() -> Result { value }
    }
}

extension Numeric.Fraction: Sendable where Result: Sendable {}
