extension Optional where Wrapped: FixedWidthInteger {

    @inlinable
    public static func +?= (lhs: inout Self, rhs: Self) {
        lhs = lhs +? rhs
    }

    @inlinable
    public static func -?= (lhs: inout Self, rhs: Self) {
        lhs = lhs -? rhs
    }

    @inlinable
    public static func *?= (lhs: inout Self, rhs: Self) {
        lhs = lhs *? rhs
    }

    @inlinable
    public static func /?= (lhs: inout Self, rhs: Self) {
        lhs = lhs /? rhs
    }

    @inlinable
    public static func %?= (lhs: inout Self, rhs: Self) {
        lhs = lhs %? rhs
    }
}
