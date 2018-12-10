extension Failable {
    
    /// See [`Optional.map(_:)`](https://developer.apple.com/documentation/swift/optional/1539476-map).
    public func map<U, Wrapped>(_ transform: (Wrapped) throws -> U) rethrows -> U? where T == Optional<Wrapped> {
        return try self.value.map(transform)
    }
    
    /// See [`Optional.flatMap(_:)`](https://developer.apple.com/documentation/swift/optional/1540500-flatmap).
    public func flatMap<U, Wrapped>(_ transform: (Wrapped) throws -> U?) rethrows -> U? where T == Optional<Wrapped> {
        return try self.value.flatMap(transform)
    }
    
    /// See [`Optional.==(_:_:)`](https://developer.apple.com/documentation/swift/optional/2950146).
    public static func == <Wrapped>(lhs: Failable<Wrapped?, Validations>, rhs: Failable<Wrapped?, Validations>)
        -> Bool where T == Optional<Wrapped>, Wrapped: Equatable
    {
        return lhs.value == rhs.value
    }
    
    /// See [`Optional.!=(_:_:)`](https://developer.apple.com/documentation/swift/optional/2949565).
    public static func != <Wrapped>(lhs: Failable<Wrapped?, Validations>, rhs: Failable<Wrapped?, Validations>)
        -> Bool where T == Optional<Wrapped>, Wrapped: Equatable
    {
        return lhs.value != rhs.value
    }
}

/// See [`Optional.??(_:_:)`](https://developer.apple.com/documentation/swift/1539917).
public func ?? <T, V>(optional: Failable<T?, V>, defaultValue: @autoclosure () throws -> T) rethrows -> T {
    return try optional.value ?? defaultValue
}

/// See [`Optional.??(_:_:)`](https://developer.apple.com/documentation/swift/1541015).
public func ?? <T, V>(optional: Failable<T?, V>, defaultValue: @autoclosure () throws -> T?) rethrows -> T? {
    return try optional.value ?? defaultValue
}
