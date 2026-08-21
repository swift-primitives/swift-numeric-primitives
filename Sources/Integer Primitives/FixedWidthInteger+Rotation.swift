extension FixedWidthInteger where Self: Sendable {

    @inlinable
    public var rotation: Numeric.Integer.Rotation<Self> {
        Numeric.Integer.Rotation(self)
    }
}
