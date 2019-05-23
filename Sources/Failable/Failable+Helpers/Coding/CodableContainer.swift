// MARK: - Keyed Container

extension KeyedDecodingContainer {
    /// Decodes a `Failable` instance with the given stored type for the given key.
    ///
    /// - Parameters:
    ///   - type: The type of `Failable` instance to decode.
    ///   - key: The key that the decoded value is associated with.
    ///
    /// - Returns: A value of the requested type, if present for the given key and convertible to the requested type.
    public func decode<T, V>(_ type: Failable<T, V>.Type, forKey key: K) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self, forKey: key)
        return try Failable(wrapped).verified()
    }

    /// Decodes a `Failable` instance with the given stored type for the given key if it exists.
    ///
    /// - Parameters:
    ///   - type: The type of `Failable` instance to decode.
    ///   - key: The key that the decoded value is associated with.
    ///
    /// - Returns: A value of the requested type, if present for the given key and convertible to the requested type.
    public func decode<T, V>(_ type: Failable<T?, V>.Type, forKey key: K) throws -> Failable<T?, V> where T: Decodable {
        let wrapped = try self.decodeIfPresent(T.self, forKey: key)
        return try Failable(wrapped).verified()
    }
}

extension KeyedEncodingContainer {
    func value<T, V>(from failable: Failable<T, V>, for key: K) throws -> T where T: Encodable {
        guard let encodable = failable.value else {
            throw EncodingError.invalidValue(failable, .init(
                codingPath: self.codingPath + [key],
                debugDescription: "Cannot encode error as value of type `\(T.self)`",
                underlyingError: failable.error
            ))
        }

        return encodable
    }


    /// Encodes the given `Failable` value for the given key.
    ///
    /// - Parameters:
    ///   - value: The value to encode.
    ///   - key: The key to associate the value with.
    public mutating func encode<T, V>(_ value: Failable<T, V>, forKey key: K) throws where T: Encodable {
        try self.encode(self.value(from: value, for: key), forKey: key)
    }

    /// Encodes the given `Failable` value for the given key if it exists.
    ///
    /// - Parameters:
    ///   - value: The value to encode.
    ///   - key: The key to associate the value with.
    public mutating func encode<T, V>(_ value: Failable<T?, V>, forKey key: K) throws where T: Encodable {
        try self.encodeIfPresent(self.value(from: value, for: key), forKey: key)
    }
}

// MARK: - Unkeyed Container

extension UnkeyedDecodingContainer {
    /// Decodes a value of the given type.
    ///
    /// - Parameter type: The type of `Failable` instance to decode.
    /// - Returns: A value of the requested type, if present for the given key and convertible to the requested type.
    public mutating func decode<T, V>(_ type: Failable<T, V>.Type) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self)
        return try Failable(wrapped).verified()
    }

    /// Decodes a value of the given type.
    ///
    /// - Parameter type: The type of `Failable` instance to decode.
    /// - Returns: A value of the requested type, if present for the given key and convertible to the requested type.
    public mutating func decode<T, V>(_ type: Failable<T?, V>.Type) throws -> Failable<T?, V> where T: Decodable {
        let wrapped = try self.decodeIfPresent(T.self)
        return try Failable(wrapped).verified()
    }
}

extension UnkeyedEncodingContainer {
    func value<T, V>(from failable: Failable<T, V>) throws -> T where T: Encodable {
        guard let encodable = failable.value else {
            throw EncodingError.invalidValue(failable, .init(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode error as value of type `\(T.self)`",
                underlyingError: failable.error
            ))
        }

        return encodable
    }

    /// Encodes the given `Failable` value.
    ///
    /// - Parameter value: The value to encode.
    public mutating func encode<T, V>(_ value: Failable<T, V>) throws where T: Encodable {
        try self.encode(self.value(from: value))
    }

    /// Encodes the given `Failable` value if it exists.
    ///
    /// If the value stored by the `Failable` instance is `nil`, then `.encodeNil()` is called instead.
    ///
    /// - Parameter value: The value to encode.
    public mutating func encode<T, V>(_ value: Failable<T?, V>) throws where T: Encodable {
        if let encodable = try self.value(from: value) {
            try self.encode(encodable)
        } else {
            try self.encodeNil()
        }
    }
}

// MARK: Single Value Container

extension SingleValueDecodingContainer {
    /// Decodes a single `Failable` value of the given type.
    ///
    /// - Parameter type: The type of `Failable` instance to decode.
    /// - Returns: A value of the requested type.
    public func decode<T, V>(_ type: Failable<T, V>.Type) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self)
        return try Failable(wrapped).verified()
    }

    /// Decodes a single `Failable` value of the given type.
    ///
    /// - Parameter type: The type of `Failable` instance to decode.
    /// - Returns: A value of the requested type.
    public func decode<T, V>(_ type: Failable<T?, V>.Type) throws -> Failable<T?, V> where T: Decodable {
        if self.decodeNil() {
            return try Failable(nil).verified()
        } else {
            let wrapped = try self.decode(T.self)
            return try Failable(wrapped).verified()
        }
    }
}

extension SingleValueEncodingContainer {
    func value<T, V>(from failable: Failable<T, V>) throws -> T where T: Encodable {
        guard let encodable = failable.value else {
            throw EncodingError.invalidValue(failable, .init(
                codingPath: self.codingPath,
                debugDescription: "Cannot encode error as value of type `\(T.self)`",
                underlyingError: failable.error
            ))
        }

        return encodable
    }

    /// Encodes a single `Failable` value.
    ///
    /// - Parameter value: The value to encode.
    public mutating func encode<T, V>(_ value: Failable<T, V>) throws where T: Encodable {
        try self.encode(self.value(from: value))
    }

    /// Encodes a single `Failable` value if it exists.
    ///
    /// If the value stored by the `Failable` instance is `nil`, then `.encodeNil()` is called instead.
    ///
    /// - Parameter value: The value to encode.
    public mutating func encode<T, V>(_ value: Failable<T?, V>) throws where T: Encodable {
        if let encodable = try self.value(from: value) {
            try self.encode(encodable)
        } else {
            try self.encodeNil()
        }
    }
}

