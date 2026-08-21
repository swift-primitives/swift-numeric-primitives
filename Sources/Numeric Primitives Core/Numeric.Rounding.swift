extension Numeric {

    public enum Rounding: Sendable, Equatable {

        case direction(Direction)

        case nearest(Nearest)

        case odd

        case exact

        public enum Direction: Sendable, Equatable {

            case down

            case up

            case zero

            case away
        }

        public enum Nearest: Sendable, Equatable {

            case down

            case up

            case zero

            case away

            case even
        }
    }
}

extension Numeric.Rounding {

    @inlinable
    public static var down: Self { .direction(.down) }

    @inlinable
    public static var up: Self { .direction(.up) }

    @inlinable
    public static var zero: Self { .direction(.zero) }

    @inlinable
    public static var away: Self { .direction(.away) }

    @inlinable
    public static var even: Self { .nearest(.even) }
}

#if !hasFeature(Embedded)
    extension Numeric.Rounding: Codable {}
    extension Numeric.Rounding.Direction: Codable {}
    extension Numeric.Rounding.Nearest: Codable {}
#endif
