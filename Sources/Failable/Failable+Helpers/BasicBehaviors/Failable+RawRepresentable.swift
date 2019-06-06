extension Validated: RawRepresentable where T: RawRepresentable {
    /// See [`RawRepresentable.RawValue`](https://developer.apple.com/documentation/swift/rawrepresentable/1540809-rawvalue).
    public typealias RawValue = Result<T.RawValue, Error>

    /// See [`RawRepresentable.init(rawValue:)`](https://developer.apple.com/documentation/swift/rawrepresentable/1538354-inithttps://developer.apple.com/documentation/swift/rawrepresentable/1538354-init)
    public init?(rawValue: RawValue) {
        guard case let .success(raw) = rawValue, let value = T(rawValue: raw) else { return nil }
        self = Validated(initialValue: value)
    }

    /// See [`RawRepresentable.rawValue`](https://developer.apple.com/documentation/swift/rawrepresentable/1540698-rawvalue).
    public var rawValue: Result<T.RawValue, Error> {
        return Result(catching: { try self.get().rawValue })
    }
}

extension Validated: CaseIterable where T: CaseIterable {
    /// See [`CaseIterable.AllCases`](https://developer.apple.com/documentation/swift/caseiterable/2994868-allcases).
    public typealias AllCases = Array<Validated<T, Validations>>

    /// See [`CaseIterable.allCases`](https://developer.apple.com/documentation/swift/caseiterable/2994869-allcases)
    public static var allCases: AllCases {
        return T.allCases.map(Validated.init)
    }
}
