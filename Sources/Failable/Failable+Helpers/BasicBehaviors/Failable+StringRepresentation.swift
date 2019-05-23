extension Failable: CustomStringConvertible where T: CustomStringConvertible {
    /// See [`CustomStringConvertible.description`](https://developer.apple.com/documentation/swift/customstringconvertible/1539130-description).
    public var description: String {
        switch self.stored {
        case let .success(value): return "Failable(" + value.description + ")"
        case let .failure(error): return "Failable(error: " + error.localizedDescription + ")"
        }
    }
}

extension Failable: LosslessStringConvertible where T: LosslessStringConvertible {
    /// See [`LosslessStringConvertible.init(_:)`](https://developer.apple.com/documentation/swift/losslessstringconvertible/2429639-init).
    public init?(_ description: String) {
        guard let value = T(description) else { return nil }
        self.init(value)
    }
}

extension Failable: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    /// See [`CustomDebugStringConvertible.debugDescription`](https://developer.apple.com/documentation/swift/customdebugstringconvertible/1540125-debugdescription).
    public var debugDescription: String {
        return "Failable(value: " + self.value.debugDescription + ", validations: " + String(describing: Validations.self) + ")"
    }
}
