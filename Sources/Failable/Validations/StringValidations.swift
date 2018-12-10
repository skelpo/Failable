import Foundation

/// Checks that a `String` value contains a match to a regular expression pattern somewhere in it.
///
///     struct USPhoneNumber: RegexValidation {
///         static let pattern = "1?-?\\(?[0-9]{3}\\)?-?[0-9]{3}-?[0-9]{4}"
///     }
///
/// If you want to make sure the RegEx pattern matches the whole string, use the `^` and `$` operators at the start and end of the pattern.
///
/// If the string passed in to be validated does not contain a match for the RegEx pattern, `ValidationError.noRegexMatch` will be thrown.
public protocol RegexValidation: Validation where Supported == String {
    
    /// The regular expression pattern to match values against.
    static var pattern: String { get }
}

extension RegexValidation {
    
    /// See `Validation.validate(_:)`.
    public static func validate(_ value: String)throws {
        guard value.range(of: self.pattern, options: .regularExpression) != nil else {
            throw ValidationError(identifier: "noRegexMatch", reason: "Unable to find match for pattern `\(self.pattern)` in value")
        }
    }
}
