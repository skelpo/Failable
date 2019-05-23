extension Failable: Sequence where T: Sequence {
    /// See [`Sequence.Element`](https://developer.apple.com/documentation/swift/sequence/2908099-element).
    public typealias Element = Failable<T.Element, EmptyValidation<T.Element>>

    /// See [`IteratorProtocol`](https://developer.apple.com/documentation/swift/iteratorprotocol).
    ///
    /// Wraps the stored value's iterator and converts the resulting value to a `Failable` instance.
    /// If the `Failable` instance holds an error instead of a value, the `.next()` method always returns `nil`.
    public struct Iterator: IteratorProtocol {

        /// See [`IteratorProtocol.Element`](https://developer.apple.com/documentation/swift/iteratorprotocol/1641632-element).
        public typealias Element = Failable.Element

        var internalIterator: AnyIterator<T.Element>?

        init<I>(iterator: I? = nil) where I: IteratorProtocol, I.Element == T.Element {
            self.internalIterator = iterator.map(AnyIterator<T.Element>.init)
        }

        /// See [`IteratorProtocol.next()`](https://developer.apple.com/documentation/swift/iteratorprotocol/1641682-next).
        public mutating func next() -> Element? {
            if self.internalIterator != nil {
                return (self.internalIterator?.next()).map(Element.init(_:))
            } else {
                return nil
            }
        }
    }

    /// See
    /// [`Sequence.underestimatedCount`](https://developer.apple.com/documentation/swift/sequence/3018375-underestimatedcount).
    public var underestimatedCount: Int {
        return self.value?.underestimatedCount ?? 0
    }

    /// See [`Sequence.makeIterator()`](https://developer.apple.com/documentation/swift/sequence/2885155-makeiterator).
    public func makeIterator() -> Iterator {
        return Iterator(iterator: self.value?.makeIterator())
    }
}

extension Failable: Collection where T: Collection {
    /// See [`Collection.Index`](https://developer.apple.com/documentation/swift/collection/2943866-index).
    public typealias Index = Failable<T.Index, EmptyValidation<T.Index>>

    /// See [`Collection.startIndex`](https://developer.apple.com/documentation/swift/collection/2946080-startindex).
    public var startIndex: Index {
        return self[keyPath: \.startIndex]
    }

    /// See [`Collection.endIndex`](https://developer.apple.com/documentation/swift/collection/2944204-endindex).
    public var endIndex: Failable<T.Index, EmptyValidation<T.Index>> {
        return self[keyPath: \.endIndex]
    }

    /// See [`Collection.subscript(_:)`](https://developer.apple.com/documentation/swift/collection/1641358-subscript).
    public subscript (position: Index) -> Element {
        get {
            return Failable.map(self, position) { collection, index in collection[index] }
        }
    }

    /// See [`Collection.index(after:)`](https://developer.apple.com/documentation/swift/collection/2943746-index).
    public func index(after i: Failable<T.Index, EmptyValidation<T.Index>>) -> Failable<T.Index, EmptyValidation<T.Index>> {
        return Failable.map(self, i) { collection, index in collection.index(after: index) }
    }
}

extension Failable: BidirectionalCollection where T: BidirectionalCollection {
    /// See [`BidirectionalCollection.index(before:)`](https://developer.apple.com/documentation/swift/bidirectionalcollection/3017603-formindex).
    public func index(before i: Failable<T.Index, EmptyValidation<T.Index>>) -> Failable<T.Index, EmptyValidation<T.Index>> {
        return Failable.map(self, i) { collection, index in collection.index(before: index) }
    }
}

extension Failable: RandomAccessCollection where T: RandomAccessCollection { }

extension Failable: MutableCollection where T: MutableCollection {
    /// See [`MutableCollection.subscript(_:)`](https://developer.apple.com/documentation/swift/mutablecollection/1640969-subscript).
    public subscript (position: Index) -> Element {
        get {
            return Failable.map(self, position) { collection, index in collection[index] }
        }
        set {
            if let value = newValue.value, let index = position.value {
                self.value?[index] = value
            }
        }
    }
}

extension Failable: RangeReplaceableCollection where T: RangeReplaceableCollection {
    /// See [`RangeReplaceableCollection.init()`](https://developer.apple.com/documentation/swift/rangereplaceablecollection/1641467-init).
    public init() {
        self = Failable(T())
    }
}
