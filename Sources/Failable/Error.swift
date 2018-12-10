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
}
