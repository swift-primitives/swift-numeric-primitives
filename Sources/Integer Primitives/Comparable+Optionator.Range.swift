extension Optional where Wrapped: Comparable {

    @inlinable
    public static func ..<? (lhs: Self, rhs: Self) -> Swift.Range<Wrapped>? {
        guard let a = lhs, let b = rhs, a < b else { return nil }
        return a..<b
    }

    @inlinable
    public static func ...? (lhs: Self, rhs: Self) -> ClosedRange<Wrapped>? {
        guard let a = lhs, let b = rhs, a <= b else { return nil }
        return a...b
    }
}
