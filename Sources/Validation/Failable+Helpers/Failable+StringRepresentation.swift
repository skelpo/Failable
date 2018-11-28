extension Failable: CustomStringConvertible where T: CustomStringConvertible {
    
    /// See [`CustomStringConvertible.description`](https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description).
    public var description: String {
        return "Failable(" + self.value.description + ")"
    }
}

extension Failable: LosslessStringConvertible where T: LosslessStringConvertible {
    
    /// See [`LosslessStringConvertible.init(_:)`](https://developer.apple.com/documentation/swift/losslessstringconvertible/2429639-init).
    ///
    /// If the value passed into the `Failable` initializer throws an error, the initializer with return `nil`.
    public init?(_ description: String) {
        guard let value = T(description) else { return nil }
        do {
            try self.init(value)
        } catch {
            return nil
        }
    }
}
