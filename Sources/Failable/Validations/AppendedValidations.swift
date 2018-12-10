/// A combination of two validations.
///
/// This validation is used for things such as numeric operations where `Failable` types with different validations are used.
///
/// The validations used must have the same `Supported` type.
public struct AppendedValidations<T, V1, V2>: Validation where V1: Validation, V2: Validation, V1.Supported == T, V2.Supported == T {
    
    /// See `Validation.Supported`.
    public typealias Supported = T
    
    /// See `Validation.subvalidations`.
    ///
    /// This array contains the `V1` and `V2` validation types passed into the type signiture.
    public static var subvalidations: [AnyValidation.Type] {
        return [V1.self, V2.self]
    }
}

