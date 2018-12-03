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

extension Failable: BidirectionalCollection where T: BidirectionalCollection {
    
    /// See [`BidirectionalCollection.index(before:)`](https://developer.apple.com/documentation/swift/bidirectionalcollection/1783013-index).
    public func index(before i: T.Index) -> T.Index {
        return self.value.index(before: i)
    }
}

extension Failable: RandomAccessCollection where T: RandomAccessCollection {}

extension Failable where T: MutableCollection {
    
    /// See [`MutableCollection.[]`](https://developer.apple.com/documentation/swift/mutablecollection/1640969-subscript).
    ///
    /// To validate the new array, the instance is copied and mutated, then the validation is run on the mutated instance.
    /// If the validation succeeds, the mutated value is assigned to the current instance. If the validation fails, the set silently fails.
    public subscript(position: T.Index) -> T.Element {
        get {
            return self.value[position]
        }
        set(newValue) {
            var copy = self
            copy.value[position] = newValue
            
            do {
                try self <~ copy.value
            } catch {}
        }
    }
    
    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool)throws -> Index {
        var copy = self.value
        let index = try copy.partition(by: belongsInSecondPartition)
        
        try self <~ copy
        return index
    }
    
    public mutating func swapAt(_ i: Index, _ j: Index)throws {
        var copy = self.value
        copy.swapAt(i, j)
        
        try self <~ copy
    }
}
