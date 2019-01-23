// MARK: - Keyed Container

extension KeyedDecodingContainer {
    public func decode<T, V>(_ type: Failable<T, V>.Type, forKey key: K) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self, forKey: key)
        return try .init(wrapped)
    }
    
    public func decode<T, V>(_ type: Failable<T?, V>.Type, forKey key: K) throws -> Failable<T?, V> where T: Decodable {
        let wrapped = try self.decodeIfPresent(T.self, forKey: key)
        return try .init(wrapped)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T, V>(_ value: Failable<T, V>, forKey key: K) throws where T: Encodable {
        try self.encode(value.value, forKey: key)
    }
    
    public mutating func encode<T, V>(_ value: Failable<T?, V>, forKey key: K) throws where T: Encodable {
        try self.encodeIfPresent(value.value, forKey: key)
    }
}

// MARK: - Unkeyed Container

extension UnkeyedDecodingContainer {
    public mutating func decode<T, V>(_ type: Failable<T, V>.Type) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self)
        return try .init(wrapped)
    }
    
    public mutating func decode<T, V>(_ type: Failable<T?, V>.Type) throws -> Failable<T?, V> where T: Decodable {
        let wrapped = try self.decodeIfPresent(T.self)
        return try .init(wrapped)
    }
}

extension UnkeyedEncodingContainer {
    public mutating func encode<T, V>(_ value: Failable<T, V>) throws where T: Encodable {
        try self.encode(value.value)
    }
    
    public mutating func encode<T, V>(_ value: Failable<T?, V>) throws where T: Encodable {
        if value.value == nil {
            try self.encodeNil()
        } else {
            try self.encode(value.value)
        }
    }
}

// MARK: Single Value Container

extension SingleValueDecodingContainer {
    public func decode<T, V>(_ type: Failable<T, V>.Type) throws -> Failable<T, V> where T: Decodable {
        let wrapped = try self.decode(T.self)
        return try .init(wrapped)
    }
    
    public func decode<T, V>(_ type: Failable<T?, V>.Type) throws -> Failable<T?, V> where T: Decodable {
        if self.decodeNil() {
            return try .init(nil)
        } else {
            let wrapped = try self.decode(T.self)
            return try .init(wrapped)
        }
    }
}

extension SingleValueEncodingContainer {
    public mutating func encode<T, V>(_ value: Failable<T, V>) throws where T: Encodable {
        try self.encode(value.value)
    }
    
    public mutating func encode<T, V>(_ value: Failable<T?, V>) throws where T: Encodable {
        if value.value == nil {
            try self.encodeNil()
        } else {
            try self.encode(value.value)
        }
    }
}

