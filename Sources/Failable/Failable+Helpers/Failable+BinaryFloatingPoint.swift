extension Failable where T: BinaryFloatingPoint {
    
    // MARK: - Typealiases
    
    /// See [`BinaryFloatingPoint.RawExponent`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846956-rawexponent).
    public typealias RawExponent = T.RawExponent
    
    /// See [`BinaryFloatingPoint.RawSignificand`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1848447-rawsignificand).
    public typealias RawSignificand = T.RawSignificand
    
    
    // MARK: - Initializers
    
    /// See [`BinaryFloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846451-init).
    public init(_ value: Float)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`BinaryFloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1847139-init).
    public init(_ value: Double)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`BinaryFloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1852769-init).
    public init(_ value: Float80)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`BinaryFloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/3017610-init).
    public init<Source>(_ value: Source)throws where Source : BinaryFloatingPoint {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`BinaryFloatingPoint.init(exactly:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/3017611-init).
    public init?<Source>(exactly value: Source)throws where Source : BinaryFloatingPoint {
        guard let t = T(exactly: value) else { return nil }
        try? self.init(t)
    }
    
    /// See [`BinaryFloatingPoint.init(sign:exponentBitPattern:significandBitPattern:)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1849503-init).
    public init(sign: FloatingPointSign, exponentBitPattern: RawExponent, significandBitPattern: RawSignificand)throws {
        let t = T(sign: sign, exponentBitPattern: exponentBitPattern, significandBitPattern: significandBitPattern)
        try self.init(t)
    }
    
    
    // MARK: - Properties
    
    /// See [`BinaryFloatingPoint.binade`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1848292-binade).
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public var binade: Failable<T, Validations> {
        return try! Failable(self.value.binade)
    }
    
    /// See [`BinaryFloatingPoint.exponentBitPattern`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846505-exponentbitpattern).
    public var exponentBitPattern: RawExponent {
        return self.value.exponentBitPattern
    }
    
    /// See [`BinaryFloatingPoint.significandBitPattern`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1845838-significandbitpattern).
    public var significandBitPattern: RawSignificand {
        return self.value.significandBitPattern
    }
    
    /// See [`BinaryFloatingPoint.significandWidth`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1847322-significandwidth).
    public var significandWidth: Int {
        return self.value.significandWidth
    }
    
    /// See [`BinaryFloatingPoint.exponentBitCount`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1847221-exponentbitcount).
    public static var exponentBitCount: Int {
        return T.exponentBitCount
    }
    
    /// See [`BinaryFloatingPoint.significandBitCount`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846714-significandbitcount).
    public static var significandBitCount: Int {
        return T.significandBitCount
    }
}
