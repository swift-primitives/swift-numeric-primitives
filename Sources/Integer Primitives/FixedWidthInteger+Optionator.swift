extension Optional where Wrapped: FixedWidthInteger {

    @inlinable
    public static func +? (lhs: Self, rhs: Self) -> Self {
        guard let a = lhs, let b = rhs else { return nil }
        let (result, overflow) = a.addingReportingOverflow(b)
        return overflow ? nil : result
    }

    @inlinable
    public static func -? (lhs: Self, rhs: Self) -> Self {
        guard let a = lhs, let b = rhs else { return nil }
        let (result, overflow) = a.subtractingReportingOverflow(b)
        return overflow ? nil : result
    }

    @inlinable
    public static func *? (lhs: Self, rhs: Self) -> Self {
        guard let a = lhs, let b = rhs else { return nil }
        let (result, overflow) = a.multipliedReportingOverflow(by: b)
        return overflow ? nil : result
    }

    @inlinable
    public static func /? (lhs: Self, rhs: Self) -> Self {
        guard let a = lhs, let b = rhs, b != 0 else { return nil }
        let (result, overflow) = a.dividedReportingOverflow(by: b)
        return overflow ? nil : result
    }

    @inlinable
    public static func %? (lhs: Self, rhs: Self) -> Self {
        guard let a = lhs, let b = rhs, b != 0 else { return nil }
        let (result, overflow) = a.remainderReportingOverflow(dividingBy: b)
        return overflow ? nil : result
    }
}

extension Optional where Wrapped: FixedWidthInteger & SignedNumeric {

    @inlinable
    public static prefix func -? (value: Self) -> Self {
        guard let v = value else { return nil }
        let (result, overflow) = (0 as Wrapped).subtractingReportingOverflow(v)
        return overflow ? nil : result
    }
}
