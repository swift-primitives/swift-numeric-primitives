extension Numeric {

    public enum Augmented {}
}

extension Numeric.Augmented {

    @inlinable
    public static func product<T: FloatingPoint>(
        _ a: T,
        _ b: T
    ) -> (head: T, tail: T) {
        let head = a * b
        let tail = (-head).addingProduct(a, b)
        return (head, tail)
    }
}

extension Numeric.Augmented {

    @inlinable
    public static func sum<T: FloatingPoint>(
        _ a: T,
        _ b: T
    ) -> (head: T, tail: T) {
        let head = a + b
        let x = head - b
        let y = head - x
        let tail = (a - x) + (b - y)
        return (head, tail)
    }

    @inlinable
    public static func sum<T: FloatingPoint>(
        large: T,
        small: T
    ) -> (head: T, tail: T) {

        guard T.radix == 2 else { return sum(large, small) }

        let head = large + small
        let tail = large - head + small
        return (head, tail)
    }
}
