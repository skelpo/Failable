extension Failable: SIMDStorage where T: SIMDStorage {
    /// See [`SIMDStorage.Scalar`](https://developer.apple.com/documentation/swift/simdstorage/3140578-scalar)
    public typealias Scalar = Failable<T.Scalar, EmptyValidation<T.Scalar>>

    /// See [`SIMDStorage.scalarCount`](https://developer.apple.com/documentation/swift/simdstorage/3140580-scalarcount)
    public var scalarCount: Int {
        return self.value?.scalarCount ?? 0
    }

    /// See [`SIMDStorage.init()`](https://developer.apple.com/documentation/swift/simdstorage/3140579-init).
    public init() {
        self = Failable(T())
    }

    /// See [`subscript(_:)`](https://developer.apple.com/documentation/swift/simdstorage/3140581-subscript).
    public subscript(index: Int) -> Scalar {
        get {
            return self.map { vectors in vectors[index] }
        }
        set {
            if let value = newValue.value {
                self.value?[index] = value
            }
        }
    }
}

extension Failable: SIMD where T: SIMD {
    /// See [`SIMD.MaskStorage`](https://developer.apple.com/documentation/swift/simd/3139486-maskstorage).
    public typealias MaskStorage = T.MaskStorage
}
