extension Validated: CustomStringConvertible where T: CustomStringConvertible {
    /// See [`CustomStringConvertible.description`](https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description).
    public var description: String {
        switch self {
        case let .value(value): return "Validated(" + value.description + ")"
        case let .error(error): return "Validated(error: " + error.localizedDescription + ")"
        }
    }
}

extension Validated: LosslessStringConvertible where T: LosslessStringConvertible {
    /// See [`LosslessStringConvertible.init(_:)`](https://developer.apple.com/documentation/swift/losslessstringconvertible/2429639-init).
    public init?(_ description: String) {
        guard let value = T(description) else { return nil }
        self.init(initialValue: value)
    }
}

extension Validated: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    /// See [`CustomDebugStringConvertible.debugDescription`](https://developer.apple.com/documentation/swift/customdebugstringconvertible/1540125-debugdescription).
    public var debugDescription: String {
        return "Validated(value: " + self.value.debugDescription + ", validations: " + String(describing: Validations.self) + ")"
    }
}
