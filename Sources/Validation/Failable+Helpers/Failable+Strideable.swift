extension Failable where T: Strideable {
    
    /// See [`Strideable.Stride`](https://developer.apple.com/documentation/swift/strideable/1541220-stride).
    public typealias Stride = T.Stride
    
    /// See [`Strideable.advance(by:)`](https://developer.apple.com/documentation/swift/strideable/1641148-advanced).
    public func advance(by n: Stride)throws -> Failable<T, Validations> {
        return try Failable(self.value.advanced(by: n))
    }
    
    /// See [`Strideable.distance(to:)`](https://developer.apple.com/documentation/swift/strideable/1641148-advanced).
    public func distance(to other: Failable<T, Validations>) -> Stride {
        return self.value.distance(to: other.value)
    }
    
    /// See [`Strideable.+(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2885404).
    public static func + (lhs: Failable<T, Validations>, rhs: Stride)throws -> Failable<T, Validations> {
        return try lhs.advance(by: rhs)
    }
    
    /// See [`Strideable.+(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2886679).
    public static func + (lhs: Stride, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try rhs.advance(by: lhs)
    }
    
    /// See [`Strideable.+=(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2884440).
    public static func += (lhs: inout Failable<T, Validations>, rhs: Stride)throws {
        try lhs <~ lhs.advance(by: rhs).value
    }
    
    /// See [`Strideable.-(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2884623).
    public static func - (lhs: Failable<T, Validations>, rhs: Stride)throws -> Failable<T, Validations> {
        return try lhs.advance(by: -rhs)
    }
    
    /// See [`Strideable.-(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2886160).
    public static func - (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Stride {
        return rhs.distance(to: lhs)
    }
    
    /// See [`Strideable.-=(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2885177).
    public static func -= (lhs: inout Failable<T, Validations>, rhs: Stride)throws {
        try lhs <~ lhs.advance(by: -rhs).value
    }
}

extension Failable where T: Strideable, T.Stride: SignedInteger {
    
    /// See [`Stridable....(_:_:)`](https://developer.apple.com/documentation/swift/strideable/2950083).
    public static func ... (
        lhs: Failable<T, Validations>,
        rhs: Failable<T, Validations>
    )throws -> Failable<ClosedRange<T>, ElementValidation<ClosedRange<T>, Validations>> {
        return try (lhs.value...rhs.value).failable()
    }
}
