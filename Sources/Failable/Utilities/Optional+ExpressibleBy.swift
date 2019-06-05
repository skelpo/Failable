extension Optional: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {
    /// See [`ExpressibleByIntegerLiteral.init(integerLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyintegerliteral/2298913-init).
    public init(integerLiteral value: Wrapped.IntegerLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(integerLiteral: value))
    }
}

extension Optional: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {
    /// See [`ExpressibleByFloatLiteral.init(floatLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyfloatliteral/2294405-init).
    public init(floatLiteral value: Wrapped.FloatLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(floatLiteral: value))
    }
}

extension Optional: ExpressibleByBooleanLiteral where Wrapped: ExpressibleByBooleanLiteral {
    /// See [`ExpressibleByBooleanLiteral.init(booleanLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebybooleanliteral/2296011-init).
    public init(booleanLiteral value: Wrapped.BooleanLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(booleanLiteral: value))
    }
}

extension Optional: ExpressibleByStringLiteral where Wrapped: ExpressibleByStringLiteral {
    /// See [`ExpressibleByStringLiteral.init(stringLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebystringliteral/2294174-init)
    public init(stringLiteral value: Wrapped.StringLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(stringLiteral: value))
    }
}

extension Optional: ExpressibleByExtendedGraphemeClusterLiteral
    where Wrapped: ExpressibleByExtendedGraphemeClusterLiteral
{
    /// See [`ExpressibleByExtendedGraphemeClusterLiteral.init(extendedGraphemeClusterLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyextendedgraphemeclusterliteral/2294280-init).
    public init(extendedGraphemeClusterLiteral value: Wrapped.ExtendedGraphemeClusterLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(extendedGraphemeClusterLiteral: value))
    }
}

extension Optional: ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByUnicodeScalarLiteral {
    /// See [`ExpressibleByUnicodeScalarLiteral.init(unicodeScalarLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyunicodescalarliteral/2296043-init).
    public init(unicodeScalarLiteral value: Wrapped.UnicodeScalarLiteralType) {
        self = Optional<Wrapped>.some(Wrapped(unicodeScalarLiteral: value))
    }
}

extension Optional: ExpressibleByArrayLiteral where Wrapped: ExpressibleByArrayLiteral {
    /// See [`ExpressibleByArrayLiteral.init(arrayLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral/2908652-init).
    public init(arrayLiteral elements: Wrapped.ArrayLiteralElement...) {
        let initializer = unsafeBitCast(
            Wrapped.init(arrayLiteral:),
            to: (([Wrapped.ArrayLiteralElement]) -> Wrapped).self
        )
        self = Optional<Wrapped>.some(initializer(elements))
    }
}

extension Optional: ExpressibleByDictionaryLiteral where Wrapped: ExpressibleByDictionaryLiteral {
    /// See [`ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral/2295781-init).
    public init(dictionaryLiteral elements: (Wrapped.Key, Wrapped.Value)...) {
        let initializer = unsafeBitCast(
            Wrapped.init(dictionaryLiteral:),
            to: (([(Wrapped.Key, Wrapped.Value)]) -> Wrapped).self
        )
        self = Optional(initializer(elements))
    }
}

