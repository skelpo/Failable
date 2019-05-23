/// An error that occurs while validating a value.
public struct ValidationError: Codable, Error {
    
    /// The machine readable ID for the error.
    public let identifier: String
    
    /// The human readable reason that the error occured.
    public let reason: String
    
    /// Creates a new `ValidationError` instance.
    ///
    /// - Parameters:
    ///   - identifier: The machine readable ID for the error.
    ///   - reason: The human readable reason that the error occured.
    public init(identifier: String, reason: String) {
        self.identifier = identifier
        self.reason = reason
    }

    /// Creates a `ValidationError.operationFailed` error.
    ///
    /// This error is used when an operation is called on a `Failable` instance, but the given instance
    /// holds an error instead of a valid value.
    ///
    /// - Parameter error: The error held by the `Failable` instance.
    /// - Returns: A `ValidationError` instance with `operationFailed` as the identifier.
    static func foundError(_ error: Error) -> ValidationError {
        return ValidationError(
            identifier: "operationFailed",
            reason: "Found error instead of expected value.\nError: \(error.localizedDescription)"
        )
    }
}
