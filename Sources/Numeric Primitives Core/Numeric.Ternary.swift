// Numeric.Ternary.swift

public import Pair_Primitives

extension Numeric {
    /// Balanced ternary digit: -1, 0, or +1.
    ///
    /// Used in balanced ternary numeral systems where digits are -1, 0, +1 (also
    /// known as a "trit"). More symmetric than binary with simple negation and no
    /// separate sign bit. Use for balanced ternary arithmetic or three-state logic.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let t: Numeric.Ternary = .positive
    /// print(t.intValue)              // 1
    /// print(t.negated)               // negative
    /// print(t.multiplying(.negative)) // negative
    /// ```
    public enum Ternary: Int, Sendable, Hashable, CaseIterable {
        /// Negative one (-1).
        case negative = -1

        /// Zero (0).
        case zero = 0

        /// Positive one (+1).
        case positive = 1
    }
}

// MARK: - Negation

extension Numeric.Ternary {
    /// Negated ternary value (swaps positive↔negative, preserves zero).
    @inlinable
    public static func negated(_ ternary: Numeric.Ternary) -> Numeric.Ternary {
        switch ternary {
        case .negative: return .positive
        case .zero: return .zero
        case .positive: return .negative
        }
    }

    /// Negated ternary value (swaps positive↔negative, preserves zero).
    @inlinable
    public var negated: Numeric.Ternary {
        Self.negated(self)
    }

    /// Returns the negated value.
    @inlinable
    public static prefix func - (value: Numeric.Ternary) -> Numeric.Ternary {
        value.negated
    }
}

// MARK: - Arithmetic

extension Numeric.Ternary {
    /// Integer value (-1, 0, or +1).
    @inlinable
    public var intValue: Int { rawValue }

    /// Multiplies two ternary values (standard integer multiplication).
    @inlinable
    public static func multiplying(_ lhs: Numeric.Ternary, _ rhs: Numeric.Ternary) -> Numeric.Ternary {
        Numeric.Ternary(rawValue: lhs.rawValue * rhs.rawValue) ?? .zero
    }

    /// Multiplies two ternary values (standard integer multiplication).
    @inlinable
    public func multiplying(_ other: Numeric.Ternary) -> Numeric.Ternary {
        Self.multiplying(self, other)
    }
}

// MARK: - From Sign

extension Numeric.Ternary {
    /// Creates a ternary value from a sign.
    @inlinable
    public init(_ sign: Numeric.Sign) {
        switch sign {
        case .positive: self = .positive
        case .negative: self = .negative
        case .zero: self = .zero
        }
    }
}

// MARK: - Tagged Value

extension Numeric.Ternary {
    /// A value paired with a ternary digit.
    public typealias Value<Payload> = Pair<Numeric.Ternary, Payload>
}

// MARK: - Codable

#if !hasFeature(Embedded)
    extension Numeric.Ternary: Codable {}
#endif
