extension Failable: Collection where T: Collection {
    
    /// See [`Collection.SubSequence`](https://developer.apple.com/documentation/swift/collection/1641276-subsequence)
    public typealias SubSequence = T.SubSequence
    
    /// See [`Collection.Index`](https://developer.apple.com/documentation/swift/collection/2943866-index).
    public typealias Index = T.Index
    
    /// See [`Collection.startIndex`](https://developer.apple.com/documentation/swift/collection/2946080-startindex).
    public var startIndex: T.Index {
        return self.value.startIndex
    }
    
    /// See [`Collection.endIndex`](https://developer.apple.com/documentation/swift/collection/2944204-endindex).
    public var endIndex: T.Index {
        return self.value.endIndex
    }
    
    /// See [`Collection.[]`](https://developer.apple.com/documentation/swift/collection/1641358-subscript).
    public subscript(position: Index) -> Element {
        return self.value[position]
    }
    
    /// See [`Collection.index(after:)`](https://developer.apple.com/documentation/swift/collection/2943746-index).
    public func index(after i: T.Index) -> T.Index {
        return self.value.index(after: i)
    }
}

