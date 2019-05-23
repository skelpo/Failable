extension Failable where T == Bool {
    /// See [`Bool.toggle()`](https://developer.apple.com/documentation/swift/bool/2994863-toggle).
    public mutating func toggle() {
        self.value?.toggle()
    }
}
