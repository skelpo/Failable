extension Failable where T: SignedNumeric {
    
    /// See [`SignedNumeric.negate()`](https://developer.apple.com/documentation/swift/signednumeric/2883859-negate).
    public mutating func negate()throws {
        try self = -self
    }
    
    /// See [`SignedNumeric.-(_:)`](https://developer.apple.com/documentation/swift/signednumeric/2965579).
    public static prefix func - (lhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(-lhs.value)
    }
}
