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

/// A combination of two errors that have occured.
public struct ErrorJoin: Error, CustomStringConvertible {

    /// One the of the errors that is joined.
    public let left: Error

    /// One the of the errors that is joined.
    public let right: Error

    /// Creates a new `ErrorJoin` instance from two other errors.
    ///
    /// - Parameters:
    ///   - left: One the of the errors that is joined.
    ///   - right: One the of the errors that is joined.
    public init(_ left: Error, _ right: Error) {
        self.left = left
        self.right = right
    }

    /// See `CustomStringConvertible.description`.
    ///
    /// - Returns: A string formatted as `(left.description|right.description)`.
    public var description: String {
        return "(\(self.left.localizedDescription)|\(self.right.localizedDescription))"
    }
}
