/// A `Failable` type with a validation that can't fail.
public typealias AlwaysValidated<T> = Validated<T, EmptyValidation<T>>

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


@propertyDelegate
public enum Validated<T, Validations> where Validations: Validation, Validations.Supported == T {
    case value(T)
    case error(Error)

    public init(by validations: Validations.Type = Validations.self, value: T) {
        self = Validated(initialValue: value)
    }

    public init(initialValue: T?) {
        guard let value = initialValue else {
           self = .error(ValidationError(
                identifier: "unexpectedNil",
                reason: "Cannot iniitialize value of type `\(T.self)` from `nil` value")
            )
            return
        }
        do {
            try Validations.run(value)
            self = .value(value)
        } catch let error {
            self = .error(error)
        }
    }

    public var value: T? {
        get {
            guard case let .value(value) = self else { return nil }
            return value
        }
        set {
            if newValue == nil, !_isOptional(T.self) { return }
            guard let value = newValue else { return }

            do {
                try Validations.run(value)
                self = .value(value)
            } catch let error {
                self = .error(error)
            }
        }
    }

    public func validate()throws -> Validated {
        guard case let .error(error) = self else {
            return self
        }
        throw error
    }

    public func get()throws -> T {
        switch self {
        case let .value(value): return value
        case let .error(error): throw error
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
    public func map<Value, NewValidations>(
        _ transform: (_ value: T)throws -> Value
    ) -> Validated<Value, NewValidations> {
        switch self {
        case let .value(value):
            do { return try .init(initialValue: transform(value)) }
            catch { return .error(error) }
        case let .error(error): return .error(error)
        }
    }

    /// Converts the stored value to another value of the same type with the same validations.
    ///
    /// - Parameters:
    ///   - transform: The mapping function to convert the stored value.
    ///   - value: The stored value of the current instance to convert.
    ///
    /// - Returns: A new `Failable` instance with value returned by the `transform` closure.
    public func map(_ transform: (_ value: T)throws -> T) -> Validated<T, Validations> {
        switch self {
        case let .value(value):
            do { return try .init(initialValue: transform(value)) }
            catch { return .error(error) }
        case let .error(error): return .error(error)
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
        _ transform: (T)throws -> Validated<Value, NewValidations>
    ) -> Validated<Value, NewValidations> {
        switch self {
        case let .value(value):
            do { return try transform(value) }
            catch { return .error(error) }
        case let .error(error): return .error(error)
        }
    }

    /// Converts the stored value to a `Failable` instance with matching `T` and `Validations` types.
    ///
    /// - Parameters:
    ///   - transform: The mapping closure that convert the stored value to a `Failable` instance.
    ///   - value: The stored value of the current instance that will be converted.
    ///
    /// - Returns: The `Failable` instance that was returned from the `trasnform` closure.
    public func flatMap(_ transform: (_ value: T)throws -> Validated<T, Validations>) -> Validated<T, Validations> {
        switch self {
        case let .value(value):
            do { return try transform(value) }
            catch { return .error(error) }
        case let .error(error): return .error(error)
        }
    }
}

extension Validated {
    public static func map<A, B, R, AV, BV, RV>(
        _ left: Validated<A, AV>,
        _ right: Validated<B, BV>,
        closure: (A, B)throws -> R
    ) -> Validated<R, RV> {
        switch (left, right) {
        case let (.value(l), .value(r)):
            do {
                return try Validated<R, RV>(initialValue: closure(l, r))
            } catch let error {
                return .error(error)
            }
        case let (.error(l), .error(r)): return .error(ValidationError.foundError(ErrorJoin(l, r)))
        case let (.value, .error(error)): return .error(ValidationError.foundError(error))
        case let (.error(error), .value): return .error(ValidationError.foundError(error))
        }
    }
}
