extension Failable where T: BinaryInteger {
    
    /// See [`BinaryInteger.Words`](https://developer.apple.com/documentation/swift/binaryinteger/2894610-words).
    public typealias Words = T.Words
    
    /// See [`BinaryInteger.init()`](https://developer.apple.com/documentation/swift/binaryinteger/2885991-init).
    public init()throws {
        let t = T()
        try self.init(t)
    }
    
    /// See [`BinaryInteger.init(_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884166-init).
    public init<B>(_ source: B)throws where B : BinaryFloatingPoint {
        let t = T(source)
        try self.init(t)
    }
    
    /// See [`BinaryInteger.init(_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885704-init).
    public init<B>(_ source: B)throws where B : BinaryInteger {
        let t = T(source)
        try self.init(t)
    }
    
    /// See [`BinaryInteger.init(clamping:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886143-init).
    public init<B>(clamping source: B)throws where B : BinaryInteger {
        let t = T(clamping: source)
        try self.init(t)
    }
    
    /// See [`BinaryInteger.init(exactly:)`](https://developer.apple.com/documentation/swift/binaryinteger/2925955-init).
    ///
    /// If an error is thrown by the `Failable` initializer, then this init will return `nil`.
    public init?<B>(exactly source: B) where B : BinaryFloatingPoint {
        guard let t = T(exactly: source) else { return nil }
        try? self.init(t)
    }
    
    /// See [`BinaryInteger.init(truncatingIfNeeded:)`](https://developer.apple.com/documentation/swift/binaryinteger/2925529-init).
    public init<T>(truncatingIfNeeded source: T)throws where T : BinaryInteger {
        let t = T(truncatingIfNeeded: source)
        try self.init(t)
    }
    
    /// See [`BinaryInteger.bidWidth`](https://developer.apple.com/documentation/swift/binaryinteger/2886690-bitwidth).
    public var bidWidth: Int {
        return self.value.bitWidth
    }
    
    /// See [`BinaryInteger.trailingZeroBitCount`](https://developer.apple.com/documentation/swift/binaryinteger/2886715-trailingzerobitcount).
    public var trailingZeroBitCount: Int {
        return self.value.trailingZeroBitCount
    }
    
    /// See [`BinaryInteger.words`](https://developer.apple.com/documentation/swift/binaryinteger/2892492-words).
    public var words: Words {
        return self.value.words
    }
    
    /// See [`BinaryInteger.isSigned`](https://developer.apple.com/documentation/swift/binaryinteger/2886485-issigned).
    public static var isSigned: Bool {
        return T.isSigned
    }
    
    /// See [`BinaryInteger.quotientAndRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017639-quotientandremainder).
    public func quotientAndRemainder(dividingBy rhs: Failable<T, Validations>)throws
        -> (quotient: Failable<T, Validations>, remainder: Failable<T, Validations>)
    {
        let qar = self.value.quotientAndRemainder(dividingBy: rhs.value)
        return try (Failable(qar.quotient), Failable(qar.remainder))
    }
    
    /// See [`BinaryInteger.signum()`](https://developer.apple.com/documentation/swift/binaryinteger/3017643-signum).
    public func signum()throws -> Failable<T, Validations> {
        return try Failable(self.value.signum())
    }
    
    /// See [`BinaryInteger.!=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885339).
    public static func != <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value != rhs
    }
    
    /// See [`BinaryInteger.!=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885737).
    public static func != (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value != rhs.value
    }
    
    /// See [`BinaryInteger.%(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885003).
    public static func % (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value % rhs.value)
    }
    
    /// See [`BinaryInteger.%=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886158).
    public static func %= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs % rhs
    }
    
    /// See [`BinaryInteger.&(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017613).
    public static func & (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value & rhs.value)
    }
    
    /// See [`BinaryInteger.&=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885976).
    public static func &= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs & rhs
    }
    
    /// See [`BinaryInteger.*(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884580).
    public static func * (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value * rhs.value)
    }
    
    /// See [`BinaryInteger.*=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884627).
    public static func *= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs * rhs
    }
    
    /// See [`BinaryInteger.+(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885923).
    public static func + (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value + rhs.value)
    }
    
    /// See [`BinaryInteger.+=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886064).
    public static func += (lhs: inout Failable<T, Validations> , rhs: Failable<T, Validations> )throws {
        try lhs = lhs + rhs
    }
    
    /// See [`BinaryInteger.-(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884248).
    public static func - (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value - rhs.value)
    }
    
    /// See [`BinaryInteger.-=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884261).
    public static func -= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs - rhs
    }
    
    /// See [`BinaryInteger./(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885552).
    public static func / (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value / rhs.value)
    }
    
    /// See [`BinaryInteger./=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885191).
    public static func /= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs / rhs
    }
    
    /// See [`BinaryInteger.<(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885984).
    public static func < <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value < rhs
    }
    
    /// See [`BinaryInteger.<<(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017617).
    public static func << <RHS>(lhs: Failable<T, Validations>, rhs: RHS)throws -> Failable<T, Validations> where RHS : BinaryInteger {
        return try Failable(lhs.value << rhs)
    }
    
    /// See [`BinaryInteger.<<=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2926303).
    public static func <<= <RHS>(lhs: inout Failable<T, Validations>, rhs: RHS)throws where RHS : BinaryInteger {
        try lhs = lhs << rhs
    }
    
    /// See [`BinaryInteger.<=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884735).
    public static func <= (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value <= rhs.value
    }
    
    /// See [`BinaryInteger.<=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886797).
    public static func <= <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value <= rhs
    }
    
    /// See [`BinaryInteger.==(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886030).
    public static func == <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value == rhs
    }
    
    /// See [`BinaryInteger.>(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884492).
    public static func > <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value > rhs
    }
    
    /// See [`BinaryInteger.>(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886190).
    public static func > (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value > rhs.value
    }
    
    /// See [`BinaryInteger.>=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2883970).
    public static func >= (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value == rhs.value
    }
    
    /// See [`BinaryInteger.>=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885916).
    public static func >= <Other>(lhs: Failable<T, Validations>, rhs: Other) -> Bool where Other : BinaryInteger {
        return lhs.value >= rhs
    }
    
    /// See [`BinaryInteger.>>(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017625).
    public static func >> <RHS>(lhs: Failable<T, Validations>, rhs: RHS)throws -> Failable<T, Validations> where RHS: BinaryInteger {
        return try Failable(lhs.value >> rhs)
    }
    
    /// See [`BinaryInteger.>>=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2926011).
    public static func >>= <RHS>(lhs: inout Failable<T, Validations>, rhs: RHS)throws where RHS : BinaryInteger {
        try lhs = lhs >> rhs
    }
    
    /// See [`BinaryInteger.^(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017635).
    public static func ^ (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value ^ rhs.value)
    }
    
    /// See [`BinaryInteger.^=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885182).
    public static func ^= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs ^ rhs
    }
    
    /// See [`BinaryInteger.|(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017645).
    public static func | (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value | rhs.value)
    }
    
    /// See [`BinaryInteger.|=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884669).
    public static func |= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs | rhs
    }
    
    /// See [`BinaryInteger.~(_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2883740).
    public prefix static func ~ (x: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(~x.value)
    }
}


/// Checks for inequality between two `Failable` values iw the same stored type but different validations.
///
/// - Parameters:
///   - lhs: The left value to check.
///   - rhs: The right value to check.
///
/// - Returns: The boolean value that represents whether the value are non-equal or not.
public func != <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: BinaryInteger {
    return lhs.value != rhs.value
}

/// Produces the remainder of dividing a `Failable` value by another, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The dividend in the equation.
///   - rhs: The divisor in the equation.
///
/// - Returns: The remainder of the division problem, with the validations of both `Failalble` types passed in.
public func % <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value % rhs.value)
}

/// Produces the result of a bitwise AND operatoion on two `Failable` values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value for the operation.
///   - rhs: The right value for the operation.
///
/// - Returns: The result of the operation, with the validations of both `Failalble` types passed in.
public func & <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value & rhs.value)
}

/// Produces the product of two `Failable` values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The value to multiply.
///   - rhs: The value to multiply the first value by.
///
/// - Returns: The product of the equation, with the validations of both `Failalble` types passed in.
public func * <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value * rhs.value)
}

/// Produces the sum of two `Failable` values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
///
/// - Returns: The sum of the two values, with the validations of both `Failalble` types passed in.
public func + <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value + rhs.value)
}

/// Produces the difference of two `Failable` values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract from the left value.
///
/// - Returns: The difference of the two values, with the validations of both `Failalble` types passed in.
public func - <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value - rhs.value)
}

/// Produces the quotient of dividing on `Failable` value by another, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The dividend in the equation.
///   - rhs: The divisor in the equation.
///
/// - Returns: The quotient of the division problem, with the validations of both `Failalble` types passed in.
public func / <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value / rhs.value)
}

/// Returns a Boolean value indicating whether the value of the first argument is less than
/// or equal to that of the second argument, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value to check.
///   - rhs: The right value to check.
///
/// - Returns: The boolean value that represents whether the first value is less than or equal to the second.
public func <= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: BinaryInteger {
    return lhs.value <= rhs.value
}

/// Returns a Boolean value indicating whether the value of the first argument is greater than
/// that of the second argument, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value to check.
///   - rhs: The right value to check.
///
/// - Returns: The boolean value that represents whether the first value is greater than the second.
public func > <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: BinaryInteger {
    return lhs.value > rhs.value
}

/// Returns a Boolean value indicating whether the value of the first argument is greater than
/// or equal to that of the second argument, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value to check.
///   - rhs: The right value to check.
///
/// - Returns: The boolean value that represents whether the first value is greater than or equal to the second.
public func >= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: BinaryInteger {
    return lhs.value == rhs.value
}

/// Returns the result of performing a bitwise XOR operation on the two given values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value in the operation.
///   - rhs: The right value in the operation.
///
/// - Returns: The result of the XOR operation, with the validation types from both values passed in.
public func ^ <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value ^ rhs.value)
}

/// Returns the result of performing a bitwise OR operation on the two given values, where the `Validations` types are different.
///
/// - Parameters:
///   - lhs: The left value in the operation.
///   - rhs: The right value in the operation.
///
/// - Returns: The result of the OR operation, with the validation types from both values passed in.
public func | <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: BinaryInteger {
    return try Failable(lhs.value | rhs.value)
}
