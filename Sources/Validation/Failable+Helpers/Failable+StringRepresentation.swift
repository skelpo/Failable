extension Failable: CustomStringConvertible where T: CustomStringConvertible {
    
    /// See [`CustomStringConvertible.description`](https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description).
    public var description: String {
        return "Failable(" + self.value.description + ")"
    }
}
