extension Failable where T: Numeric {
    
    /// See [`Numeric.Magnitude`](https://developer.apple.com/documentation/swift/numeric/2884423-magnitude).
    public typealias Magnitude = T.Magnitude
    
    /// See [`Numeric.init(exactly:)`](https://developer.apple.com/documentation/swift/numeric/2886795-init).
    public init?<B>(exactly source: B) where B : BinaryInteger {
        guard let t = T(exactly: source) else { return nil }
        do {
            try self.init(t)
        } catch { return nil }
    }
    
    /// See [`Numeric.magnitude`](https://developer.apple.com/documentation/swift/numeric/2884876-magnitude).
    public var magnitude: T.Magnitude {
        return self.value.magnitude
    }
    
    /// See [`Numeric.*(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2883821).
    public static func * (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value * rhs.value)
    }
    
    /// See [`Numeric.*=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2886882).
    public static func *= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs <~ lhs.value * rhs.value
    }
    
    /// See [`Numeric.+(_:)`]https://developer.apple.com/documentation/swift/numeric/2886206).
    public static prefix func + (lhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return lhs
    }
    
    /// See [`Numeric.+(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2884921).
    public static func + (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value + rhs.value)
    }
    
    /// See [`Numeric.+=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2885744).
    public static func += (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs <~ lhs.value + rhs.value
    }
    
    /// See [`Numeric.-(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2885464).
    public static func - (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value - rhs.value)
    }
    
    /// See [`Numeric.-=(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2884360).
    public static func -= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs <~ lhs.value - rhs.value
    }
}


/// Multiplies two values from `Failable` instances and produces their product, combining the validations.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to multiply.
///
/// - Returns: The product of the `value` values from the two `Failable` instances.
///   The validations for the new `Failalbe` value is a combination of the validations from both instances.
public func * <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: Numeric {
    return try Failable(lhs.value * rhs.value)
}

/// Multiplies two values from `Failable` instances and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to multiply.
public func *= <T, V1, V2>(lhs: inout Failable<T, V1>, rhs: Failable<T, V2>)throws where T: Numeric {
    try lhs <~ lhs.value * rhs.value
}

/// Adds two values from `Failable` instances and produces their sum, combining the validations.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
///
/// - Returns: The sum of the `value` values from the two `Failable` instances.
///   The validations for the new `Failalbe` value is a combination of the validations from both instances.
public func + <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: Numeric {
    return try Failable(lhs.value + rhs.value)
}

/// Adds two values from `Failable` instances and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
public func += <T, V1, V2>(lhs: inout Failable<T, V1>, rhs: Failable<T, V2>)throws where T: Numeric {
    try lhs <~ lhs.value + rhs.value
}

/// Subtracts one `Failable` value from another and produces their difference, combining the validations.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract.
///
/// - Returns: The product of the `value` values from the two `Failable` instances.
///   The validations for the new `Failalbe` value is a combination of the validations from both instances.
public func - <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> where T: Numeric {
    return try Failable(lhs.value - rhs.value)
}

/// Subtracts one `Failable` value from another and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract.
public func -= <T, V1, V2>(lhs: inout Failable<T, V1>, rhs: Failable<T, V2>)throws where T: Numeric {
    try lhs <~ lhs.value - rhs.value
}


/// Multiplies a `Failable` value with another `T` value and produces their product.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to multiply.
///
/// - Returns: The product of the `Failable.value` property and the `rhs` value.
public func * <T, V1>(lhs: Failable<T, V1>, rhs: T)throws -> Failable<T, V1> where T: Numeric {
    return try Failable(lhs.value * rhs)
}

/// Multiplies a `Failable` value with another `T` value and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to multiply.
public func *= <T, V1>(lhs: inout Failable<T, V1>, rhs: T)throws where T: Numeric {
    try lhs <~ lhs.value * rhs
}

/// Adds a `Failable` value to another `T` value and produces their sum.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
///
/// - Returns: The sum of the `Failable.value` property and the `rhs` value.
public func + <T, V1>(lhs: Failable<T, V1>, rhs: T)throws -> Failable<T, V1> where T: Numeric {
    return try Failable(lhs.value + rhs)
}

/// Adds a `Failable` value to another `T` value and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
public func += <T, V1>(lhs: inout Failable<T, V1>, rhs: T)throws where T: Numeric {
    try lhs <~ lhs.value + rhs
}

/// Subtracts `T` value from a `Failable` value and produces their difference.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract.
///
/// - Returns: The difference of the `Failable.value` property and the `rhs` value.
public func - <T, V1>(lhs: Failable<T, V1>, rhs: T)throws -> Failable<T, V1> where T: Numeric {
    return try Failable(lhs.value - rhs)
}

/// Subtracts a `T` value from a `Failable` value and stores the result in the left-hand-side `Failable` instance.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract.
public func -= <T, V1>(lhs: inout Failable<T, V1>, rhs: T)throws where T: Numeric {
    try lhs <~ lhs.value - rhs
}
