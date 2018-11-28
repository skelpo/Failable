/// A validation type that verifies the length of a type conforming to `Collection`.
///
///     struct LengthRange10To1028: LengthValidation {
///         static let maxLength: Int = 1028
///         static let minLength: Int = 10
///     }
///
/// If the value passed into the `validate` method has a length the is greater than `maxLength`, `ValidationError.lengthToLong` is thrown.
/// If the value has a length less than `minLength`, `ValidationError.lengthToShort` is thrown.
public protocol LengthValidation: Validation where Supported: Collection {
    
    /// The maximum length that the validated collection can have.
    static var maxLength: Int { get }
    
    /// The minimum length that the validated collection can have.
    ///
    /// This value defaults to `0`.
    static var minLength: Int { get }
}

extension LengthValidation {
    static var minLength: Int { return 0 }
    
    /// See `Validation.validate(_:)`.
    static func validate(_ value: Supported)throws {
        guard value.count <= self.maxLength else {
            throw ValidationError(identifier: "lengthToLong", reason: "Length of collection value is greater than \(self.maxLength)")
        }
        guard value.count >= self.minLength else {
            throw ValidationError(identifier: "lengthToShort", reason: "Length of collection value is less than \(self.minLength)")
        }
    }
}


/// Validates each element in a sequence using a custom validation function.
///
///     struct StringLengthArray: ElementValidation {
///         static var validator: (String)throws -> Void = { str in
///             guard str.count <= 1028 else { throw ValidationError(identifier: "lengthToLong", reason: "String must have length 1028 or less") }
///         }
///     }
///
/// The `validate` method calls `.forEach` on the value passed in and passes the `validator` function in as the closure.
public protocol ElementValidation: Validation where Supported: Sequence {
    
    /// The function used to validate each element in the sequence.
    static var validator: (Supported.Element)throws -> Void { get }
}

extension ElementValidation {
    
    /// See `Validation.validate(_:)`.
    static func validate(_ value: Supported)throws {
        return try value.forEach(self.validator)
    }
}
