extension Validated: Equatable where T: Equatable {
    /// See [`Equatable.==(_:_:)`](https://developer.apple.com/documentation/swift/equatable/1539854).
    public static func == (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Bool {
        switch (lhs, rhs) {
        case let (.value(left), .value(right)): return left == right
        case let (.error(left), .error(right)): return left.localizedDescription == right.localizedDescription
        default: return false
        }
    }
}

extension Validated: Comparable where T: Comparable {
    /// See [`Comparable.<(_:_:)`](https://developer.apple.com/documentation/swift/comparable/1538311).
    public static func < (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Bool {
        switch (lhs, rhs) {
        case let (.value(left), .value(right)): return left < right
        default: return false
        }
    }
}

extension Validated: Hashable where T: Hashable {
    /// See [`Hashable.hash(into:)`](https://developer.apple.com/documentation/swift/hashable/2995575-hash).
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .value(value): hasher.combine(value)
        case let .error(error): hasher.combine(error.localizedDescription)
        }
    }
}
