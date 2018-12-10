/// A validation type that verifies the length of a type conforming to `Collection`.
///
///     internal struct LengthRange10To1028<C>: LengthValidation where C: Collection {
///         typealias Supported = C
///
///         static var maxLength: Int { return 1028 }
///         static var minLength: Int { return  10 }
///     }
///
/// If the value passed into the `validate` method has a length the is greater than `maxLength`, `ValidationError.lengthTooLong` is thrown.
/// If the value has a length less than `minLength`, `ValidationError.lengthTooShort` is thrown.
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
            throw ValidationError(identifier: "lengthTooLong", reason: "Length of collection value is greater than \(self.maxLength)")
        }
        guard value.count >= self.minLength else {
            throw ValidationError(identifier: "lengthTooShort", reason: "Length of collection value is less than \(self.minLength)")
        }
    }
}

/// Validates each element in a sequence using another validator.
///
/// The `validate` method calls `.forEach` on the value passed in and passes the `Validator.run` method in as the closure.
public struct ElementValidation<Seq, Validator>: Validation where Seq: Sequence, Validator: Validation, Validator.Supported == Seq.Element {
    public typealias Supported = Seq
    
    public static func validate(_ value: Seq)throws {
        try value.forEach(Validator.run)
    }
}
