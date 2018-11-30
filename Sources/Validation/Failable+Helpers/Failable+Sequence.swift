extension Failable: Sequence where T: Sequence {
    
    /// See [`Sequence.Element`](https://developer.apple.com/documentation/swift/sequence/2908099-element).
    public typealias Element = T.Element
    
    // See [`Sequence.Iterator`](https://developer.apple.com/documentation/swift/sequence/1641120-iterator).
    public typealias Iterator = T.Iterator
    
    /// See [`Sequence.makeIterator()`](https://developer.apple.com/documentation/swift/sequence/2885155-makeiterator).
    public func makeIterator() -> T.Iterator {
        return self.value.makeIterator()
    }
}
