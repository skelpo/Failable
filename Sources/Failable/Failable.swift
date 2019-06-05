/// A `Failable` type with a validation that can't fail.
public typealias NonFailable<T> = Failable<T, EmptyValidation<T>>

/// A type that can fail when being set because the new value does pass certain validations.
///
/// You can create a `Failable` instance in 2 ways. The first is to use the `Failable` initializer:
///
///     try Failable<String, Length1028>("the quick brown fox...")
///
/// Or you can call `.failable` on any intance of a type conforming to `CustomStringConvertible`:
///
///     try "the quick brown fox...".failable(Length1028.self)
///
/// ## Mutation
///
/// A `Failable` type is a struct, so the stored value can only be mutated if the `Failable` instance is a variable.
/// The stored value does not make its setter public, because then you would be able to set the value directly and bypass the validations.
/// Instead you use the `<~` operator to assign a new value:
///
///     var story = try "the quick brown fox...".failable(Length1028.self)
///     try story <~ "Long long ago, on a pencil far far away..."
///
/// Use the `.value` property to access the actual value:
///
///     var story = try "the quick brown fox...".failable(Length1028.self)
///     print(story.value)
///
/// ## Literal Initialization
///
/// `Failable` supprts initialization with certain type literals if the `value` type `T` also supports it.
/// Initialization is supported for `Int`, `Float`, `Bool`, `nil`, and `String` types.
///
///     let string = Failable<String, EmptyValidation<String>> = "Hello world"
///
/// - Warning: Because literal initializers cannot fail, your program will crash if the value passed in does not pass validation.
///
/// `Dictionary` and `Array` types are not supported for literal initialization yet because array
/// splatting for variadic parameters is not supported yet.
public struct Failable<T, Validations> where Validations: Validation, Validations.Supported == T {
    internal private(set) var stored: Result<T, Error>

    init(result: Result<T, Error>) {
        self.stored = result
    }

    init(_ error: Error) {
        self.stored = .failure(error)
    }

    /// Gets the stored value of the current instance if it exists.
    ///
    /// Thie property will return `nil` if an error is held instead.
    ///
    /// You can set the stored value if the `Failable` instance by using this properties setter.
    /// The value will not be set if `T` is non-optional and `nil` is passed in.
    public var value: T? {
        get {
            guard case let .success(value) = self.stored else { return nil }
            return value
        }
        set {
            guard !_isOptional(T.self), let value = newValue else { return }
            self.stored = Result(catching: {
                try Validations.run(value)
                return value
            })
        }
    }

    /// Gets the error stored in the current instance.
    ///
    /// This property returns `nil` if a value of type `T` is stored instead.
    public var error: Error? {
        guard case let .failure(error) = self.stored else { return nil }
        return error
    }

    /// Creates a new `Failable` instance.
    ///
    /// - Parameter t: The orginal value for the instance.
    ///   This value will be validated and the initializer will fail if it doesn't pass.
    public init(_ t: T) {
        self.stored = Result.init(catching: {
            try Validations.run(t)
            return t
        })
    }

    /// Initialize a new `Failable` instance from an already existing instance.
    /// This can be useful to specify the types of an ambiguous `Failable` instance.
    ///
    /// - Parameter failable: The `Failable` instance to initialize with.
    public init(_ failable: Failable<T, Validations>) {
        self = failable
    }

    /// Gets the value stored in the current instance.
    ///
    /// - Returns: The stored value, of type `T`.
    /// - Throws: The error stored in the current value.
    public func get()throws -> T {
        return try self.stored.get()
    }

    /// Verified that the current instance contains a value instead of an error.
    /// If an error is found, it will be thrown.
    ///
    /// - Returns: Self, if it contains a value value.
    /// - Throws: The stored `Error` instance.
    public func verified()throws -> Failable<T, Validations> {
        switch self.stored {
        case let .failure(error): throw error
        case .success: return self
        }
    }

    /// Converts the stored value to another value of a different type, which will be the stored value of a new
    /// `Failable` instance with a different `Validation` type.
    ///
    /// - Parameters:
    ///   - transform: The mapping closure that transforms the stored value.
    ///   - value: The stored value of the current instance that will be converted.
    ///
    /// - Returns: A new `Failable` instance that uses the value returned by the `transform` closure.
    public func map<Value, NewValidations>(_ transform: (_ value: T)throws -> Value) -> Failable<Value, NewValidations> {
        switch self.stored {
        case let .success(value): return Failable<Value, NewValidations>(result: Result(catching: { try transform(value) }))
        case let .failure(error): return Failable<Value, NewValidations>(result: .failure(error))
        }
    }

    /// Converts the stored value to another value of the same type with the same validations.
    ///
    /// - Parameters:
    ///   - transform: The mapping function to convert the stored value.
    ///   - value: The stored value of the current instance to convert.
    ///
    /// - Returns: A new `Failable` instance with value returned by the `transform` closure.
    public func map(_ transform: (_ value: T)throws -> T) -> Failable<T, Validations> {
        switch self.stored {
        case let .success(value): return Failable(result: Result(catching: { try transform(value) }))
        case let .failure(error): return Failable(result: .failure(error))
        }
    }

    /// Converts the stored value to a `Failable` instance that contains a value of a different type and that uses
    /// a different `Validation` type.
    ///
    /// - Parameters:
    ///   - transform: The mapping closure that converts the stored value to a `Failable` instance.
    ///   - value: The stored value of the current instance that will be converted.
    ///
    /// - Returns: The `Failable` instance that was returned from the `trasnform` closure.
    public func flatMap<Value, NewValidations>(
        _ transform: (T)throws -> Failable<Value, NewValidations>
    ) -> Failable<Value, NewValidations> {
        switch self.stored {
        case let .success(t):
            do {
                return try transform(t)
            } catch let error {
                return Failable<Value, NewValidations>(result: .failure(error))
            }
        case let .failure(error): return Failable<Value, NewValidations>(result: .failure(error))
        }
    }

    /// Converts the stored value to a `Failable` instance with matching `T` and `Validations` types.
    ///
    /// - Parameters:
    ///   - transform: The mapping closure that convert the stored value to a `Failable` instance.
    ///   - value: The stored value of the current instance that will be converted.
    ///
    /// - Returns: The `Failable` instance that was returned from the `trasnform` closure.
    public func flatMap(_ transform: (_ value: T)throws -> Failable<T, Validations>) -> Failable<T, Validations> {
        switch self.stored {
        case let .success(value):
            do {
                return try transform(value)
            } catch let error {
                return Failable(result: .failure(error))
            }
        case let .failure(error): return Failable(result: .failure(error))
        }
    }

    /// Accesses the value of a keypath for the stored value where the stored value type
    /// and the keypath value type are equivalent.
    ///
    /// - Parameter path: The keypath of the value to access.
    /// - Returns: A `Failable` instance with the value of the keypath.
    public subscript (keyPath path: KeyPath<T, T>) -> Failable<T, Validations> {
        return self.map { value in value[keyPath: path] }
    }

    /// Accesses the value of a keypath for the stored value where the stored value type and keypath value type are different.
    ///
    /// - Parameter path: The keypath of the value to access.
    /// - Returns: A `Failable` instance with the value of the keypath.
    public subscript <Value, NewValidations>(keyPath path: KeyPath<T, Value>) -> Failable<Value, NewValidations> {
        return self.map { value in value[keyPath: path] }
    }
}

extension Failable {
    public static func map<A, B, R, AV, BV, RV>(
        _ left: Failable<A, AV>,
        _ right: Failable<B, BV>,
        closure: (A, B)throws -> R
    ) -> Failable<R, RV> {
        switch (left.stored, right.stored) {
        case let (.success(l), .success(r)): return Failable<R, RV>(result: Result(catching: { try closure(l, r) }))
        case let (.failure(l), .failure(r)): return Failable<R, RV>(ValidationError.foundError(ErrorJoin(l, r)))
        case let (.success, .failure(error)): return Failable<R, RV>(ValidationError.foundError(error))
        case let (.failure(error), .success): return Failable<R, RV>(ValidationError.foundError(error))
        }
    }
}

extension CustomStringConvertible {
    
    /// Easily create `Failable` versions of types conforming to `CustomStringConvertible`. This includes most, if not all, core Swift types.
    ///
    /// This paramater defaults to its own type, so if the validation type can be infered, you don't need to pass the paramater in.
    ///
    ///     var story: Failable<String, Length1028> = try "Once upon a time...".failable()
    ///
    /// - Parameter validations: The validation type to use when mutating the stored value.
    public func failable<Validations>(_ validations: Validations.Type = Validations.self) -> Failable<Self, Validations> {
        return Failable(self)
    }
}
