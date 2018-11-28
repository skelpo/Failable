infix operator <~

/// Sets the stored value of a `Failable` type.
///
/// You have to use this operator instead of `=` so the validations always run on the new value before it is assigned.
///
/// - Note: Sub-validations are only run 1 level deep. This prevents any validation loops that could occur and saves on run time.
///
/// - Complexity: O(n), where _n_ is the number of type compatible sub-validations for the `Failable` type's sub-validations.
///
/// - Parameters:
///   - root: The `Failable` instance that holds the value to be mutated.
///   - value: The new value for the `root.value` property.
public func <~ <T, Validations>(root: inout Failable<T, Validations>, value: T)throws {
    try root.validate(value)
    root.value = value
}
