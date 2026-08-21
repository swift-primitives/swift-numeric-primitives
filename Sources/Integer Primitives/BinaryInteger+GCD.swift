extension Numeric.Integer {

    @inlinable
    public static func gcd<T: BinaryInteger>(_ a: T, _ b: T) -> T {

        var a = T(a.magnitude)
        var b = T(b.magnitude)

        while b != 0 {
            let t = b
            b = a % b
            a = t
        }
        return a
    }

    @inlinable
    public static func lcm<T: BinaryInteger>(_ a: T, _ b: T) -> T {
        if a == 0 || b == 0 { return 0 }
        let absA = T(a.magnitude)
        let absB = T(b.magnitude)
        return absA / gcd(absA, absB) * absB
    }
}
