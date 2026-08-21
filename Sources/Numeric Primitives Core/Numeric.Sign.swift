public import Pair_Primitives

extension Numeric {

    public enum Sign: Sendable, Hashable, CaseIterable {

        case positive

        case negative

        case zero
    }
}

extension Numeric.Sign {

    @inlinable
    public static func negated(_ sign: Numeric.Sign) -> Numeric.Sign {
        switch sign {
        case .positive: return .negative
        case .negative: return .positive
        case .zero: return .zero
        }
    }

    @inlinable
    public var negated: Numeric.Sign {
        Self.negated(self)
    }

    @inlinable
    public static prefix func - (value: Numeric.Sign) -> Numeric.Sign {
        value.negated
    }
}

extension Numeric.Sign {

    @inlinable
    public static func multiplying(_ lhs: Numeric.Sign, _ rhs: Numeric.Sign) -> Numeric.Sign {
        switch (lhs, rhs) {
        case (.zero, _), (_, .zero): return .zero
        case (.positive, .positive), (.negative, .negative): return .positive
        case (.positive, .negative), (.negative, .positive): return .negative
        }
    }

    @inlinable
    public func multiplying(_ other: Numeric.Sign) -> Numeric.Sign {
        Self.multiplying(self, other)
    }
}

extension Numeric.Sign {

    @inlinable
    public init<T: Comparable & AdditiveArithmetic>(_ value: T) {
        if value > .zero {
            self = .positive
        } else if value < .zero {
            self = .negative
        } else {
            self = .zero
        }
    }
}

extension Numeric.Sign {

    public typealias Value<Payload> = Pair<Numeric.Sign, Payload>
}

#if !hasFeature(Embedded)
    extension Numeric.Sign: Codable {}
#endif
