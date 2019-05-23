extension Failable: Encodable where T: Encodable {
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode)
    public func encode(to encoder: Encoder)throws {
        var container = encoder.singleValueContainer()
        switch self.stored {
        case let .success(value):
            try container.encode(value)
        case let .failure(error):
            throw EncodingError.invalidValue(self, .init(
                codingPath: encoder.codingPath,
                debugDescription: "Cannot encode error as value of type `\(T.self)`",
                underlyingError: error
            ))
        }
    }
}

extension Failable: Decodable where T: Decodable {
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init)
    public init(from decoder: Decoder)throws {
        let container = try decoder.singleValueContainer()

        if _isOptional(T.self), container.decodeNil() {
            self = try Failable(Void?.none as! T).verified()
        } else {
            self = try Failable(container.decode(T.self)).verified()
        }
    }
}
