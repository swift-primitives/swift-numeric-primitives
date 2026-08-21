extension SignedInteger where Self: Sendable {

    @inlinable
    public var division: Numeric.Integer.Division<Self> {
        Numeric.Integer.Division(self)
    }
}
