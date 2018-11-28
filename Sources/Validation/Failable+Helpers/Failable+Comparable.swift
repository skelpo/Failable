// MARK: - Equatable

extension Failable: Equatable where T: Equatable {
    
    /// See [`Equatable.==(-:_:)`](https://developer.apple.com/documentation/swift/equatable/1539854).
    public static func == (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value == rhs.value
    }
}

/// Checks for equality of the `value` property from two `Failable` instances where type `T` is the same and comforms to `Equatable`,
/// but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func == <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Equatable {
    return lhs.value == rhs.value
}

/// Checks for inequality of the `value` property from two `Failable` instances where type `T` is the same and comforms to `Equatable`,
/// but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func != <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Equatable {
    return lhs.value != rhs.value
}

// MARK: - Comparable

extension Failable: Comparable where T: Comparable {
    
    /// See [`Comparable.<(_:_:)`](https://developer.apple.com/documentation/swift/comparable/1538311)
    public static func < (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value < rhs.value
    }
}

/// Checks that the `value` property from one `Failable` instance is great than another, where type `T` is the same and comforms to `Comparable`,
/// but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func > <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Comparable {
    return lhs.value > rhs.value
}

/// Checks that the `value` property from one `Failable` instance is less than another, where type `T` is the same and comforms to `Comparable`,
/// but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func < <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Comparable {
    return lhs.value < rhs.value
}


/// Checks that the `value` property from one `Failable` instance is great than or equal to another,
/// where type `T` is the same and comforms to `Comparable`, but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func >= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Comparable {
    return lhs.value >= rhs.value
}

/// Checks that the `value` property from one `Failable` instance is less than or equal to another,
/// where type `T` is the same and comforms to `Comparable`, but the `Validations` are different.
///
/// - Parameters:
///   - lhs: The left `Failable` instance to compare.
///   - rhs: The right `Failable` instance to compare.
public func <= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: Comparable {
    return lhs.value <= rhs.value
}
