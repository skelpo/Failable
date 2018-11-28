extension Failable: ExpressibleByIntegerLiteral where T: ExpressibleByIntegerLiteral {
    
    /// See [`ExpressibleByIntegerLiteral.IntegerLiteralType`](https://developer.apple.com/documentation/swift/expressiblebyintegerliteral/2295254-integerliteraltype).
    public typealias IntegerLiteralType = T.IntegerLiteralType
    
    /// See [`ExpressibleByIntegerLiteral.init(integerLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyintegerliteral/2298913-init).
    public init(integerLiteral value: T.IntegerLiteralType) {
        let t = T.init(integerLiteral: value)
        try! self.init(t)
    }
}

extension Failable: ExpressibleByFloatLiteral where T: ExpressibleByFloatLiteral {
    
    /// See [`ExpressibleByFloatLiteral.FloatLiteralType`](https://developer.apple.com/documentation/swift/expressiblebyfloatliteral/2296813-floatliteraltype).
    public typealias FloatLiteralType = T.FloatLiteralType
    
    /// See [`ExpressibleByFloatLiteral.init(floatLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyfloatliteral/2294405-init).
    public init(floatLiteral value: T.FloatLiteralType) {
        let t = T.init(floatLiteral: value)
        try! self.init(t)
    }
}

extension Failable: ExpressibleByBooleanLiteral where T: ExpressibleByBooleanLiteral {
    
    /// See [`ExpressibleByBooleanLiteral.BooleanLiteralType`](https://developer.apple.com/documentation/swift/expressiblebybooleanliteral/2296130-booleanliteraltype).
    public typealias BooleanLiteralType = T.BooleanLiteralType
    
    /// See [`ExpressibleByBooleanLiteral.init(booleanLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebybooleanliteral/2296011-init).
    public init(booleanLiteral value: T.BooleanLiteralType) {
        let t = T.init(booleanLiteral: value)
        try! self.init(t)
    }
}

extension Failable: ExpressibleByNilLiteral where T: ExpressibleByNilLiteral {
    
    /// See [`ExpressibleByNilLiteral.init(nilLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebynilliteral).
    public init(nilLiteral: ()) {
        let t = T.init(nilLiteral: ())
        try! self.init(t)
    }
}

extension Failable: ExpressibleByStringLiteral where T: ExpressibleByStringLiteral {
    
    /// See [`ExpressibleByStringLiteral.StringLiteralType`](https://developer.apple.com/documentation/swift/expressiblebystringliteral/2295780-stringliteraltype).
    public typealias StringLiteralType = T.StringLiteralType
    
    /// See [`ExpressibleByStringLiteral.init(stringLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebystringliteral/2294174-init)
    public init(stringLiteral value: T.StringLiteralType) {
        let t = T.init(stringLiteral: value)
        try! self.init(t)
    }
}

extension Failable: ExpressibleByExtendedGraphemeClusterLiteral where T: ExpressibleByExtendedGraphemeClusterLiteral {
    
    /// See [`ExpressibleByExtendedGraphemeClusterLiteral.ExtendedGraphemeClusterLiteralType`](https://developer.apple.com/documentation/swift/expressiblebyextendedgraphemeclusterliteral/2297729-extendedgraphemeclusterliteralty).
    public typealias ExtendedGraphemeClusterLiteralType = T.ExtendedGraphemeClusterLiteralType
    
    /// See [`ExpressibleByExtendedGraphemeClusterLiteral.init(extendedGraphemeClusterLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyextendedgraphemeclusterliteral/2294280-init).
    public init(extendedGraphemeClusterLiteral value: T.ExtendedGraphemeClusterLiteralType) {
        let t = T.init(extendedGraphemeClusterLiteral: value)
        try! self.init(t)
    }
}

extension Failable: ExpressibleByUnicodeScalarLiteral where T: ExpressibleByUnicodeScalarLiteral {
    
    /// See [`ExpressibleByUnicodeScalarLiteral.UnicodeScalarLiteralType`](https://developer.apple.com/documentation/swift/expressiblebyunicodescalarliteral/2297763-unicodescalarliteraltype).
    public typealias UnicodeScalarLiteralType = T.UnicodeScalarLiteralType
    
    /// See [`ExpressibleByUnicodeScalarLiteral.init(unicodeScalarLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyunicodescalarliteral/2296043-init).
    public init(unicodeScalarLiteral value: T.UnicodeScalarLiteralType) {
        let t = T.init(unicodeScalarLiteral: value)
        try! self.init(t)
    }
}
