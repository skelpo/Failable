public struct MagnitudeValidation<Magnitude>: Validation where Magnitude: Numeric & Comparable {
    public typealias Supported = Magnitude

    public static func validate(_ value: Magnitude)throws {
        guard value >= Magnitude.zero else {
            throw ValidationError(
                identifier: "invalidMagnitude",
                reason: "A number's magnitude must be a valid absolute value, i.e. never negative."
            )
        }
    }
}

extension Failable: Strideable where T: Strideable {
    /// See [`Strideable.Stride`](https://developer.apple.com/documentation/swift/strideable/1541220-stride).
    public typealias Stride = Failable<T.Stride, EmptyValidation<T.Stride>>

    /// See [`Strideable.advanced(by:)`](https://developer.apple.com/documentation/swift/strideable/1641148-advanced).
    public func advanced(by n: Stride) -> Failable<T, Validations> {
        return Failable.map(self, n) { start, stride in return start.advanced(by: stride) }
    }

    /// See [`Strideable.distance(to:)`](https://developer.apple.com/documentation/swift/strideable/1641775-distance).
    public func distance(to other: Failable<T, Validations>) -> Stride {
        return Failable.map(self, other) { start, end in start.distance(to: end) }
    }
}

extension Failable: AdditiveArithmetic where T: AdditiveArithmetic {
    /// See [`AdditiveArithmetic.zero`](https://developer.apple.com/documentation/swift/additivearithmetic/3126829-zero).
    public static var zero: Failable<T, Validations> {
        return Failable(T.zero)
    }

    /// See [`AdditiveArithmetic.-(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126825).
    public static func - (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Failable<T, Validations> {
        return Failable.map(lhs, rhs) { left, right in left - right }
    }

    /// See [`AdditiveArithmetic.+(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126821).
    public static func + (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Failable<T, Validations> {
        return Failable.map(lhs, rhs) { left, right in left + right }
    }

    /// See [`AdditiveArithmetic.-=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126828).
    public static func -= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>) {
        lhs = lhs - rhs
    }

    /// See [`AdditiveArithmetic.+=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126824).
    public static func += (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>) {
        lhs = lhs + rhs
    }
}

extension Failable: Numeric where T: Numeric {
    /// See [`Numeric.Magnitude`](https://developer.apple.com/documentation/swift/numeric/2884423-magnitude).
    public typealias Magnitude = Failable<T.Magnitude, MagnitudeValidation<T.Magnitude>>

    /// See [`Numeric.magnitude`](https://developer.apple.com/documentation/swift/numeric/2884876-magnitude).
    public var magnitude: Magnitude {
        return self.map { $0.magnitude }
    }

    /// See [`Numeric.init(exactly:)`](https://developer.apple.com/documentation/swift/numeric/2886795-init).
    public init?<N>(exactly source: N) where N : BinaryInteger {
        guard let value = T(exactly: source) else { return nil }
        self.init(value)
    }

    /// See [`Numeric.*(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2883821).
    public static func * (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Failable<T, Validations> {
        return Failable.map(lhs, rhs, closure: { left, right in left * right })
    }

    /// See [`Numeric.*=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2886882).
    public static func *= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>) {
        lhs = lhs * rhs
    }
}

extension Failable: SignedNumeric where T: SignedNumeric {
    /// See [`SignedNumeric.negate()`](https://developer.apple.com/documentation/swift/signednumeric/2883859-negate).
    public mutating func negate() {
        self.value?.negate()
    }

    /// See [`SignedNumeric.-(_:)`](https://developer.apple.com/documentation/swift/signednumeric/2965579).
    public static prefix func - (lhs: Failable<T, Validations>) -> Failable<T, Validations> {
        guard let value = lhs.value else { return lhs }
        return Failable<T, Validations>(-value)
    }
}
