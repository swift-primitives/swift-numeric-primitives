extension FixedWidthInteger where Self: Sendable {

    @inlinable
    public var saturating: Numeric.Integer.Saturating<Self> {
        Numeric.Integer.Saturating(self)
    }
}
