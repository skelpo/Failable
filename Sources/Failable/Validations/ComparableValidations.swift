/// A validation for checking that a value is greater or equal to a lesser value and less than or equal to a greater value.
///
///     struct NumberThousand: InRangeValidation {
///         static let max: Int? = 9_999
///         static let min: Int? = 1_000
///     }
///
/// If the value being validated is greater than the `max` value, `ValidationError.valueTooGreat` is throw.
/// If the value is less than the `min` value, `ValidationError.valueTooSmall` is thrown.
///
/// If the `max` or `min` value is `nil`, then the value being validated will not be checked against it.
/// This allows for one sided validation ranges, where you could, for example, have any number greater than 42.
public protocol InRangeValidation: Validation where Supported: Comparable {
    
    /// The maximum value that the value being validated could be.
    ///
    /// This property defaults to `nil`.
    static var max: Supported? { get }
    
    /// The miniumum value that the value being validated could be.
    ///
    /// This property defaults to `nil`.
    static var min: Supported? { get }
}

extension InRangeValidation {
    static var max: Supported? { return nil }
    static var min: Supported? { return nil }
    
    /// See `Validation.validate(_:)`.
    public static func validate(_ value: Supported)throws {
        if let max = self.max { guard value <= max else {
            throw ValidationError(identifier: "valueTooGreat", reason: "Value passed in is greater than \(max)")
        } }
        if let min = self.min { guard value >= min else {
            throw ValidationError(identifier: "valueTooSmall", reason: "Value passed in is less than \(min)")
        } }
    }
}
