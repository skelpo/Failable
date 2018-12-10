extension Failable: Sequence where T: Sequence {
    
    /// See [`Sequence.Element`](https://developer.apple.com/documentation/swift/sequence/2908099-element).
    public typealias Element = T.Element
    
    // See [`Sequence.Iterator`](https://developer.apple.com/documentation/swift/sequence/1641120-iterator).
    public typealias Iterator = T.Iterator
    
    /// See [`Sequence.makeIterator()`](https://developer.apple.com/documentation/swift/sequence/2885155-makeiterator).
    public func makeIterator() -> T.Iterator {
        return self.value.makeIterator()
    }
    
    /// See [`Sequence.split(separator:maxSplits:omittingEmptySubsequences:)`](https://developer.apple.com/documentation/swift/sequence/2908109-split).
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (T.Element) throws -> Bool) rethrows
        -> [T.SubSequence]
    {
        return try self.value.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }
    
    /// See [`Sequence.suffix(_:)`](https://developer.apple.com/documentation/swift/sequence/2965540-suffix).
    public func suffix(_ maxLength: Int) -> T.SubSequence {
        return self.value.suffix(maxLength)
    }
    
    /// See [`Sequence.prefix(while:)`](https://developer.apple.com/documentation/swift/sequence/2965528-prefix)
    public func prefix(while predicate: (T.Element) throws -> Bool) rethrows -> T.SubSequence {
        return try self.value.prefix(while: predicate)
    }
    
    /// See [`Sequence.prefix(_:)`](https://developer.apple.com/documentation/swift/sequence/2965524-prefix).
    public func prefix(_ maxLength: Int) -> T.SubSequence {
        return self.value.prefix(maxLength)
    }
    
    /// See [`Sequence.drop(while:)`](https://developer.apple.com/documentation/swift/sequence/2965501-drop).
    public func drop(while predicate: (T.Element) throws -> Bool) rethrows -> T.SubSequence {
        return try self.value.drop(while: predicate)
    }
    
    /// See [`Sequence.dropLast`](https://developer.apple.com/documentation/swift/sequence/2965508-droplast).
    public func dropLast(_ k: Int) -> T.SubSequence {
        return self.value.dropLast(k)
    }
    
    /// See [`Sequence.dropFirst(_:)`](https://developer.apple.com/documentation/swift/sequence/2965504-dropfirst).
    public func dropFirst(_ k: Int) -> T.SubSequence {
        return self.value.dropFirst(k)
    }
}
