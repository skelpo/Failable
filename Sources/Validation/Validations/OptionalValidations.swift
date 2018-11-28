/// Verified that a value is not equal to `nil`.
///
/// If the value passed in to be validated _is_ `nil`, `ValidationError.valueIsNil` is thrown.
public struct NotNil<Wrapped>: Validation {
    
    /// See `Validation.validate(_:)`.
    public static func validate(_ value: Optional<Wrapped>)throws {
        guard value != nil else {
            throw ValidationError(identifier: "valueIsNil", reason: "Expected value to exist. Found `nil` instead.")
        }
    }
}

/// Validates a value if it is not `nil`. If the value is `nil`, the validation is skipped.
public struct NotNilValidate<V>: Validation where V: Validation {
    
    /// See `Validation.validate(_:)`.
    public static func validate(_ value: Optional<V.Supported>)throws {
        guard let unwrapped = value else { return }
        try V.validate(unwrapped)
    }
}
