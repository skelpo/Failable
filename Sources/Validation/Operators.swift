infix operator <~

/// Sets the stored value of a `Failable` type.
///
/// You have to use this operator instead of `=` so the validations always run on the new value before it is assigned.
///
/// - Parameters:
///   - root: The `Failable` instance that holds the value to be mutated.
///   - value: The new value for the `root.value` property.
public func <~ <T, Validations>(root: inout Failable<T, Validations>, value: T)throws {
    try Validations.validate(value)
    try Validations.subvalidations.forEach { validation in try validation.validate(value) }
    root.value = value
}
