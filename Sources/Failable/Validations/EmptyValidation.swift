/// A `Validation` implementation that supports any type and always succeedes.
public struct EmptyValidation<T>: Validation {

    /// See `Validation.validate(_:)`.
    public static func validate(_ value: T)throws { }
}
