extension Failable: Hashable where T: Hashable {
    
    /// See [`Hashable.hash(into:)`](https://developer.apple.com/documentation/swift/hashable/2995575-hash).
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
}
