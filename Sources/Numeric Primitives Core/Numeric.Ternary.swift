public import Pair_Primitives

extension Numeric {

    public enum Ternary: Int, Sendable, Hashable, CaseIterable {

        case negative = -1

        case zero = 0

        case positive = 1
    }
}

extension Numeric.Ternary {

    @inlinable
    public static func negated(_ ternary: Numeric.Ternary) -> Numeric.Ternary {
        switch ternary {
        case .negative: return .positive
        case .zero: return .zero
        case .positive: return .negative
        }
    }

    @inlinable
    public var negated: Numeric.Ternary {
        Self.negated(self)
    }

    @inlinable
    public static prefix func - (value: Numeric.Ternary) -> Numeric.Ternary {
        value.negated
    }
}

extension Numeric.Ternary {

    @inlinable
    public var intValue: Int { rawValue }

    @inlinable
    public static func multiplying(
        _ lhs: Numeric.Ternary,
        _ rhs: Numeric.Ternary
    ) -> Numeric.Ternary {
        Numeric.Ternary(rawValue: lhs.rawValue * rhs.rawValue) ?? .zero
    }

    @inlinable
    public func multiplying(_ other: Numeric.Ternary) -> Numeric.Ternary {
        Self.multiplying(self, other)
    }
}

extension Numeric.Ternary {

    @inlinable
    public init(_ sign: Numeric.Sign) {
        switch sign {
        case .positive: self = .positive
        case .negative: self = .negative
        case .zero: self = .zero
        }
    }
}

extension Numeric.Ternary {

    public typealias Value<Payload> = Pair<Numeric.Ternary, Payload>
}

#if !hasFeature(Embedded)
    extension Numeric.Ternary: Codable {}
#endif
