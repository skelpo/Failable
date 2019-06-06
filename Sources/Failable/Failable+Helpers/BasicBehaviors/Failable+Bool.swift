extension Validated where T == Bool {
    /// See [`Bool.toggle()`](https://developer.apple.com/documentation/swift/bool/2994863-toggle).
    public mutating func toggle() {
        guard case let .value(value) = self else { return }
        self = .init(initialValue: !value)
    }
}
