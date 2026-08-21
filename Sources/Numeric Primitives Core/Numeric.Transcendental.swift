public protocol Transcendental {

    static func _sin(_ x: Self) -> Self

    static func _cos(_ x: Self) -> Self

    static func _tan(_ x: Self) -> Self

    static func _asin(_ x: Self) -> Self

    static func _acos(_ x: Self) -> Self

    static func _atan(_ x: Self) -> Self

    static func _atan2(_ y: Self, _ x: Self) -> Self

    static func _sinh(_ x: Self) -> Self

    static func _cosh(_ x: Self) -> Self

    static func _tanh(_ x: Self) -> Self

    static func _asinh(_ x: Self) -> Self

    static func _acosh(_ x: Self) -> Self

    static func _atanh(_ x: Self) -> Self

    static func _exp(_ x: Self) -> Self

    static func _expm1(_ x: Self) -> Self

    static func _exp2(_ x: Self) -> Self

    static func _log(_ x: Self) -> Self

    static func _log1p(_ x: Self) -> Self

    static func _log2(_ x: Self) -> Self

    static func _log10(_ x: Self) -> Self

    static func _pow(_ x: Self, _ y: Self) -> Self

    static func _sqrt(_ x: Self) -> Self

    static func _cbrt(_ x: Self) -> Self

    static func _hypot(_ x: Self, _ y: Self) -> Self

    static var math: Numeric.Math.Accessor<Self> { get }
}
