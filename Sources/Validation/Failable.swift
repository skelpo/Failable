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
public struct Failable<T, Validations> where Validations: Validation, Validations.Supported == T {
    
    /// The underlaying value that has been validated.
    ///
    /// - Note: The setter for this property is not public.
    public internal(set) var value: T
    
    /// Creates a new `Failable` instance.
    ///
    /// - Parameter t: The orginal value for the instance.
    ///   This value will be validated and the initializer will fail if it doesn't pass.
    public init(_ t: T)throws {
        self.value = t
        try self <~ t
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
    public func failable<Validations>(_ validations: Validations.Type = Validations.self)throws -> Failable<Self, Validations> {
        return try Failable(self)
    }
}
