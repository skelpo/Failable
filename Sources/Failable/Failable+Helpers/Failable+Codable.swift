extension Failable: Encodable where T: Encodable {
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode)
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.value)
    }
}

extension Failable: Decodable where T: Decodable {
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init)
    public init(from decoder: Decoder)throws {
        let container = try decoder.singleValueContainer()
        try self.init(container.decode(T.self))
    }
}
