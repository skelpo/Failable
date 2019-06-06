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

extension Validated: Strideable where T: Strideable {
    /// See [`Strideable.Stride`](https://developer.apple.com/documentation/swift/strideable/1541220-stride).
    public typealias Stride = AlwaysValidated<T.Stride>

    /// See [`Strideable.advanced(by:)`](https://developer.apple.com/documentation/swift/strideable/1641148-advanced).
    public func advanced(by n: Stride) -> Validated<T, Validations> {
        return Validated.map(self, n) { start, stride in return start.advanced(by: stride) }
    }

    /// See [`Strideable.distance(to:)`](https://developer.apple.com/documentation/swift/strideable/1641775-distance).
    public func distance(to other: Validated<T, Validations>) -> Stride {
        return Validated.map(self, other) { start, end in start.distance(to: end) }
    }
}

extension Validated: AdditiveArithmetic where T: AdditiveArithmetic {
    /// See [`AdditiveArithmetic.zero`](https://developer.apple.com/documentation/swift/additivearithmetic/3126829-zero).
    public static var zero: Validated<T, Validations> {
        return Validated(initialValue: T.zero)
    }

    /// See [`AdditiveArithmetic.-(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126825).
    public static func - (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in left - right }
    }

    /// See [`AdditiveArithmetic.+(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126821).
    public static func + (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in left + right }
    }

    /// See [`AdditiveArithmetic.-=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126828).
    public static func -= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs - rhs
    }

    /// See [`AdditiveArithmetic.+=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126824).
    public static func += (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs + rhs
    }
}

extension Validated: Numeric where T: Numeric {
    /// See [`Numeric.Magnitude`](https://developer.apple.com/documentation/swift/numeric/2884423-magnitude).
    public typealias Magnitude = Validated<T.Magnitude, MagnitudeValidation<T.Magnitude>>

    /// See [`Numeric.magnitude`](https://developer.apple.com/documentation/swift/numeric/2884876-magnitude).
    public var magnitude: Magnitude {
        return self.map { $0.magnitude }
    }

    /// See [`Numeric.init(exactly:)`](https://developer.apple.com/documentation/swift/numeric/2886795-init).
    public init?<N>(exactly source: N) where N : BinaryInteger {
        guard let value = T(exactly: source) else { return nil }
        self.init(initialValue: value)
    }

    /// See [`Numeric.*(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2883821).
    public static func * (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs, closure: { left, right in left * right })
    }

    /// See [`Numeric.*=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2886882).
    public static func *= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs * rhs
    }
}

extension Validated: SignedNumeric where T: SignedNumeric {
    /// See [`SignedNumeric.negate()`](https://developer.apple.com/documentation/swift/signednumeric/2883859-negate).
    public mutating func negate() {
        self.value?.negate()
    }

    /// See [`SignedNumeric.-(_:)`](https://developer.apple.com/documentation/swift/signednumeric/2965579).
    public static prefix func - (lhs: Validated<T, Validations>) -> Validated<T, Validations> {
        guard let value = lhs.value else { return lhs }
        return Validated<T, Validations>(initialValue: -value)
    }
}

/// See [`AdditiveArithmetic.-(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126825).
public func - <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: AdditiveArithmetic
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left - right }
}

/// See [`AdditiveArithmetic.+(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126821).
public func + <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: AdditiveArithmetic
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left + right }
}

/// See [`Numeric.*(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2883821).
public func * <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: Numeric
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left * right }
}

/// See [`AdditiveArithmetic.-=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126828).
public func -= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: AdditiveArithmetic {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left - right }
}

/// See [`AdditiveArithmetic.+=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126824).
public func += <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: AdditiveArithmetic {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left + right }
}

/// See [`Numeric.*=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2886882).
public func *= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: Numeric {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left * right }
}
