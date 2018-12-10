extension Failable where T: UnsignedInteger {
    
    /// See [`UnsignedInteger.magnitude`](https://developer.apple.com/documentation/swift/unsignedinteger/2884378-magnitude)
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.g
    public var magnitude: Failable<T, Validations> {
        return try! Failable(self.value.magnitude)
    }
}
