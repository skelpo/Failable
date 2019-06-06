extension Validated: ExpressibleByIntegerLiteral where T: ExpressibleByIntegerLiteral {
    /// See [`ExpressibleByIntegerLiteral.init(integerLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyintegerliteral/2298913-init).
    public init(integerLiteral value: T.IntegerLiteralType) {
        self = Validated(initialValue: T(integerLiteral: value))
    }
}

extension Validated: ExpressibleByFloatLiteral where T: ExpressibleByFloatLiteral {
    /// See [`ExpressibleByFloatLiteral.init(floatLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyfloatliteral/2294405-init).
    public init(floatLiteral value: T.FloatLiteralType) {
        self = Validated(initialValue: T(floatLiteral: value))
    }
}

extension Validated: ExpressibleByBooleanLiteral where T: ExpressibleByBooleanLiteral {
    /// See [`ExpressibleByBooleanLiteral.init(booleanLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebybooleanliteral/2296011-init).
    public init(booleanLiteral value: T.BooleanLiteralType) {
        self = Validated(initialValue: T(booleanLiteral: value))
    }
}

extension Validated: ExpressibleByNilLiteral where T: ExpressibleByNilLiteral {
    /// See [`ExpressibleByNilLiteral.init(nilLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebynilliteral).
    public init(nilLiteral: ()) {
        self = Validated(initialValue: T(nilLiteral: ()))
    }
}

extension Validated: ExpressibleByStringLiteral where T: ExpressibleByStringLiteral {
    /// See [`ExpressibleByStringLiteral.init(stringLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebystringliteral/2294174-init)
    public init(stringLiteral value: T.StringLiteralType) {
        self = Validated(initialValue: T(stringLiteral: value))
    }
}

extension Validated: ExpressibleByExtendedGraphemeClusterLiteral where T: ExpressibleByExtendedGraphemeClusterLiteral {
    /// See [`ExpressibleByExtendedGraphemeClusterLiteral.init(extendedGraphemeClusterLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyextendedgraphemeclusterliteral/2294280-init).
    public init(extendedGraphemeClusterLiteral value: T.ExtendedGraphemeClusterLiteralType) {
        self = Validated(initialValue: T(extendedGraphemeClusterLiteral: value))
    }
}

extension Validated: ExpressibleByUnicodeScalarLiteral where T: ExpressibleByUnicodeScalarLiteral {
    /// See [`ExpressibleByUnicodeScalarLiteral.init(unicodeScalarLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyunicodescalarliteral/2296043-init).
    public init(unicodeScalarLiteral value: T.UnicodeScalarLiteralType) {
        self = Validated(initialValue: T(unicodeScalarLiteral: value))
    }
}

extension Validated: ExpressibleByArrayLiteral where T: ExpressibleByArrayLiteral {
    /// See [`ExpressibleByArrayLiteral.init(arrayLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral/2908652-init).
    public init(arrayLiteral elements: T.ArrayLiteralElement...) {
        let initializer = unsafeBitCast(T.init(arrayLiteral:), to: (([T.ArrayLiteralElement]) -> T).self)
        self = Validated(initialValue: initializer(elements))
    }
}

extension Validated: ExpressibleByDictionaryLiteral where T: ExpressibleByDictionaryLiteral {
    /// See [`ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral/2295781-init).
    public init(dictionaryLiteral elements: (T.Key, T.Value)...) {
        let initializer = unsafeBitCast(T.init(dictionaryLiteral:), to: (([(T.Key, T.Value)]) -> T).self)
        self = Validated(initialValue: initializer(elements))
    }
}
