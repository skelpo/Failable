extension Failable: RawRepresentable where T: RawRepresentable {
    
    /// See [`RawRepresentable.RawValue`](https://developer.apple.com/documentation/swift/rawrepresentable/1540809-rawvalue).
    public typealias RawValue = T.RawValue
    
    /// See [`RawRepresentable.init(rawValue:)`](https://developer.apple.com/documentation/swift/rawrepresentable/1538354-init).
    ///
    /// If the `Failable` initializer throws an error, this initializer will return `nil`.
    public init?(rawValue: T.RawValue) {
        guard let value = T(rawValue: rawValue) else { return nil }
        do {
            try self.init(value)
        } catch {
            return nil
        }
    }
    
    /// See [`RawRepresentable.rawValue`](https://developer.apple.com/documentation/swift/rawrepresentable/1540698-rawvalue).
    public var rawValue: T.RawValue {
        return self.value.rawValue
    }
}

extension Failable where T: CaseIterable {
    
    /// See [`CaseIterable.AllCases`](https://developer.apple.com/documentation/swift/caseiterable/2994868-allcases).
    public typealias AllCases = T.AllCases
    
    /// See [`CaseIterable.allCases`](https://developer.apple.com/documentation/swift/caseiterable/2994869-allcases).
    public static var allCases: T.AllCases {
        return T.allCases
    }
}
