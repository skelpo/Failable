extension Failable: Equatable where T: Equatable {
    /// See [`Equatable.==(_:_:)`](https://developer.apple.com/documentation/swift/equatable/1539854).
    public static func == (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        switch (lhs.stored, rhs.stored) {
        case let (.success(left), .success(right)): return left == right
        case let (.failure(left), .failure(right)): return left.localizedDescription == right.localizedDescription
        default: return false
        }
    }
}

extension Failable: Comparable where T: Comparable {
    /// See [`Comparable.<(_:_:)`](https://developer.apple.com/documentation/swift/comparable/1538311).
    public static func < (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return Failable<Bool, EmptyValidation<Bool>>(Failable.map(lhs, rhs) { left, right in left < right }).value ?? false
    }
}

extension Failable: Hashable where T: Hashable {
    /// See [`Hashable.hash(into:)`](https://developer.apple.com/documentation/swift/hashable/2995575-hash).
    public func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Validations.self))
        hasher.combine(self.value)
    }
}
