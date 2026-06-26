// Numeric.Sign.swift

public import Pair_Primitives

extension Numeric {
    /// Three-valued sign: positive, negative, or zero.
    ///
    /// Complete numeric classification including zero as a distinct case. Forms a
    /// monoid under multiplication with identity `positive` and absorbing element
    /// `zero`. Use when working with signed numbers or implementing signum functions.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let s = Numeric.Sign(-5.0)
    /// print(s)                       // negative
    /// print(s.negated)               // positive
    /// print(s.multiplying(.positive)) // negative
    /// ```
    public enum Sign: Sendable, Hashable, CaseIterable {
        /// Greater than zero.
        case positive

        /// Less than zero.
        case negative

        /// Equal to zero.
        case zero
    }
}

// MARK: - Negation

extension Numeric.Sign {
    /// Negated sign (swaps positive↔negative, preserves zero).
    @inlinable
    public static func negated(_ sign: Numeric.Sign) -> Numeric.Sign {
        switch sign {
        case .positive: return .negative
        case .negative: return .positive
        case .zero: return .zero
        }
    }

    /// Negated sign (swaps positive↔negative, preserves zero).
    @inlinable
    public var negated: Numeric.Sign {
        Self.negated(self)
    }

    /// Returns the negated sign.
    @inlinable
    public static prefix func - (value: Numeric.Sign) -> Numeric.Sign {
        value.negated
    }
}

// MARK: - Multiplication

extension Numeric.Sign {
    /// Sign of multiplying two signed values (p×p=p, n×n=p, p×n=n, z×_=z).
    @inlinable
    public static func multiplying(_ lhs: Numeric.Sign, _ rhs: Numeric.Sign) -> Numeric.Sign {
        switch (lhs, rhs) {
        case (.zero, _), (_, .zero): return .zero
        case (.positive, .positive), (.negative, .negative): return .positive
        case (.positive, .negative), (.negative, .positive): return .negative
        }
    }

    /// Sign of multiplying two signed values (p×p=p, n×n=p, p×n=n, z×_=z).
    @inlinable
    public func multiplying(_ other: Numeric.Sign) -> Numeric.Sign {
        Self.multiplying(self, other)
    }
}

// MARK: - Numeric Detection

extension Numeric.Sign {
    /// Creates a sign from a comparable arithmetic value.
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

// MARK: - Tagged Value

extension Numeric.Sign {
    /// A value paired with its sign.
    public typealias Value<Payload> = Pair<Numeric.Sign, Payload>
}

// MARK: - Codable

#if !hasFeature(Embedded)
    extension Numeric.Sign: Codable {}
#endif
