/// A type-erased validation type.
///
/// This protocol uses `Any` instead of an associated type for the `validation` method paramater.
/// It also uses a `type` property to store what the expected input type is.
public protocol AnyValidation {
    
    /// The type that is expected as input for the `validate` method.
    ///
    /// If you are conforming to the higher-level `Validation` protocol, you should keep the default value.
    static var type: Any.Type { get }
    
    /// Validations that should also be run on a new value, besides the main validation.
    ///
    /// If your type conforms to `Validation`, you can get valiedations that take in the correct type using `safeSubvalidations`.
    static var subvalidations: [AnyValidation.Type] { get }
    
    /// Validates the value passed in. The an unexpected type is received, the `ValidationError.invalidType` will be thrown.
    ///
    /// - Parameter value: The value to validate.
    static func validate(_ value: Any)throws
}

extension AnyValidation {
    
    /// Runs the currenct validation and any subvalidations. This runs recursively until the bottom of the validation tree is found.
    ///
    /// - Parameters:
    ///   - value: The value to validate.
    ///   - type: The type that the valisation must support. If `nil` is passed in,
    ///     the type is not checked and you could get a `ValidationError.invalidType` error.
    public static func unsafeRun(_ value: Any, type: Any.Type? = nil)throws {
        try self.validate(value)
        if let unwrapped = type {
            try self.subvalidations.forEach { validation in
                guard validation.type == unwrapped else { return }
                try validation.unsafeRun(value, type: unwrapped)
            }
        } else {
            try self.subvalidations.forEach { validation in
                try validation.unsafeRun(value)
            }
        }
    }
}

/// A type that can be used to validate a new value for a `Failable` type.
///
/// A `Validation` type can only be used for a `Failable` type if `Failable.T` and `Validation.Suuported` types are the same.
///
/// An example `Validation` implementation might look like this:
///
///     struct Length1028<C>: Validation where C: Collection {
///         static func validate(_ value: C)throws {
///             guard value.count <= 1028 else { throw Error.toLong }
///         }
///     }
///
/// Both the `subvalidations` property and the `validate` method have default implementations,
/// so neither need to be implemented to conform to `Validation`.
public protocol Validation: AnyValidation {
    
    /// The type that this validation can validate.
    associatedtype Supported
    
    /// A type-safe method for validating a new value for a `Failable` instance.
    ///
    /// - Parameter value: The new value to validate.
    static func validate(_ value: Supported)throws
}

extension Validation {
    public static var type: Any.Type { return Supported.self }
    public static var subvalidations: [AnyValidation.Type] { return [] }
    
    /// The default implementation of the `Validation.validate` method. Does nothing.
    /// You should keepo the default implementation if the validation is just a collection of other validations to run.
    ///
    /// - Parameter value: The value that is supposed to be validated.
    public static func validate(_ value: Supported)throws {}
    
    /// The default implementation for the type-erased `validate` method. This implementation takes the value and trys to cast it
    /// to the associated `Support` type. If casting fails, `ValidationError.invalidType` is thrown.
    /// Otherwise, the type-safe `validate` method is called.
    ///
    /// - Parameter value: The value to validate.
    public static func validate(_ value: Any)throws {
        guard let supported = value as? Supported else {
            throw ValidationError(identifier: "invalidType", reason: "Cannot convert Any to validation supported type")
        }
        return try self.validate(supported)
    }
}

extension Validation {
    
    /// Subvalidations that expect an input type that matches the validation's `Support` type.
    public static var safeSubvalidations: [AnyValidation.Type] {
        return self.subvalidations.compactMap { validation in
            guard validation.type == Supported.self else { return nil }
            return validation
        }
    }
    
    /// Runs the currenct validation and any subvalidations that support the `Supported` type.
    /// This runs recursively until the bottom of the validation tree is found.
    ///
    /// - Parameter value: The value to validate.
    public static func run(_ value: Supported)throws {
        try self.unsafeRun(value, type: Supported.self)
    }
}
