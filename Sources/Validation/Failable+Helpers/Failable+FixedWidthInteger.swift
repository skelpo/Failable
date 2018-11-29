extension Failable where T: FixedWidthInteger {
    // MARK: - Initializers
    
    /// See [`FixedWidthInteger.init(_:radix:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2924552-init).
    ///
    /// If an error is thrown by the `Failable` initializer, this init will return `nil`.
    public init?<S>(_ text: S, radix: Int = 10) where S : StringProtocol {
        guard let t = T(text, radix: radix) else { return nil }
        try? self.init(t)
    }
    
    /// See [`FixedWidthInteger.init(bigEndian:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964311-init).
    public init(bigEndian value: Failable<T, Validations>)throws {
        let t = T(bigEndian: value.value)
        try self.init(t)
    }
    
    /// See [`FixedWidthInteger.init(littleEndian:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964313-init).
    public init(littleEndian value: Failable<T, Validations>)throws {
        let t = T(littleEndian: value.value)
        try self.init(t)
    }
    
    /// See [`FixedWidthInteger.init(bigEndian:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964311-init).
    public init<V>(bigEndian value: Failable<T, V>)throws {
        let t = T(bigEndian: value.value)
        try self.init(t)
    }
    
    /// See [`FixedWidthInteger.init(littleEndian:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964313-init).
    public init<V>(littleEndian value: Failable<T, V>)throws {
        let t = T(littleEndian: value.value)
        try self.init(t)
    }
    
    
    // MARK: - Properties
    
    /// See [`FixedWidthInteger.bigEndian`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2946083-bigendian).
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public var bigEndian: Failable<T, Validations> {
        return try! Failable(self.value.bigEndian)
    }
    
    /// A representation of this integer with the byte order swapped.
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public var byteSwapped: Failable<T, Validations> {
        return try! Failable(self.value.byteSwapped)
    }
    
    /// See [`FixedWidthInteger.leadingZeroBitCount`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2883995-leadingzerobitcount).
    public var leadingZeroBitCount: Int {
        return self.value.leadingZeroBitCount
    }
    
    /// See [`FixedWidthInteger.littleEndian`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2944924-littleendian).
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public var littleEndian: Failable<T, Validations> {
        return try! Failable(self.value.littleEndian)
    }
    
    /// See [`FixedWidthInteger.nonzeroBitCount`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885911-nonzerobitcount).
    public var nonzeroBitCount: Int {
        return self.value.nonzeroBitCount
    }
    
    
    // MARK: - Static Properties
    
    /// See [`FixedWidthInteger.bitWidth`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2886552-bitwidth).
    public static var bitWidth: Int {
        return T.bitWidth
    }
    
    /// See [`FixedWidthInteger.max`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2883788-max).
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public static var max: Failable<T, Validations> {
        return try! Failable(T.max)
    }
    
    /// See [`FixedWidthInteger.min`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884515-min).
    ///
    /// - Warning: This property has no failing options, so your program will crash if it produces a value that does not pass validation.
    public static var min: Failable<T, Validations> {
        return try! Failable(T.min)
    }
    
    
    // MARK: - Instance Methods
    
    /// See [`FixedWidthInteger.addingReportingOverflow(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885260-addingreportingoverflow).
    public func addingReportingOverflow(_ rhs: Failable<T, Validations>)throws -> (partialValue: Failable<T, Validations>, overflow: Bool) {
        let aro = self.value.addingReportingOverflow(rhs.value)
        return try (Failable(aro.partialValue), aro.overflow)
    }
    
    /// See [`FixedWidthInteger.dividedReportingOverflow(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885588-dividedreportingoverflow).
    public func dividedReportingOverflow(by rhs: Failable<T, Validations>)throws -> (partialValue: Failable<T, Validations>, overflow: Bool) {
        let dro = self.value.dividedReportingOverflow(by: rhs.value)
        return try (Failable(dro.partialValue), dro.overflow)
    }
    
    /// See [`FixedWidthInteger.dividingFullWidth(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884055-dividingfullwidth).
    public func dividingFullWidth(_ dividend: (high: Failable<T, Validations>, low: Failable<T, Validations>.Magnitude))throws
        -> (quotient: Failable<T, Validations>, remainder: Failable<T, Validations>)
    {
        let dfw = self.value.dividingFullWidth((dividend.high.value, dividend.low))
        return try (Failable(dfw.quotient), Failable(dfw.remainder))
    }
    
    /// See [`FixedWidthInteger.multipliedFullWidth(by:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884581-multipliedfullwidth).
    public func multipliedFullWidth(by other: Failable<T, Validations>)throws
        -> (high: Failable<T, Validations>, low: Failable<T, Validations>.Magnitude)
    {
        let mfw = self.value.multipliedFullWidth(by: other.value)
        return try (Failable(mfw.high), mfw.low)
    }
    
    /// See [`FixedWidthInteger.multipliedReportingOverflow(by:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884864-multipliedreportingoverflow).
    public func multipliedReportingOverflow(by rhs: Failable<T, Validations>)throws -> (partialValue: Failable<T, Validations>, overflow: Bool) {
        let mro = self.value.multipliedReportingOverflow(by: rhs.value)
        return try (Failable(mro.partialValue), mro.overflow)
    }
    
    /// See [`FixedWidthInteger.remainderReportingOverflow(dividingBy:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2892758-remainderreportingoverflow).
    public func remainderReportingOverflow(dividingBy rhs: Failable<T, Validations>)throws
        -> (partialValue: Failable<T, Validations>, overflow: Bool)
    {
        let rro = self.value.remainderReportingOverflow(dividingBy: rhs.value)
        return try (Failable(rro.partialValue), rro.overflow)
    }
    
    /// See [`FixedWidthInteger.subtractingReportingOverflow(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885098-subtractingreportingoverflow).
    public func subtractingReportingOverflow(_ rhs: Failable<T, Validations>)throws -> (partialValue: Failable<T, Validations>, overflow: Bool) {
        let sro = self.value.subtractingReportingOverflow(rhs.value)
        return try (Failable(sro.partialValue), sro.overflow)
    }
    
    
    // MARK: - Static Methods
    
    /// See [`FixedWidthInteger.random(in:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2995512-random)
    public static func random(in range: ClosedRange<Failable<T, Validations>>)throws -> Failable<T, Validations> {
        return try Failable(T.random(in: range.lowerBound.value...range.upperBound.value))
    }
    
    /// See [`FixedWidthInteger.random(in:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2995514-random)
    public static func random(in range: Range<Failable<T, Validations>>)throws -> Failable<T, Validations> {
        return try Failable(T.random(in: range.lowerBound.value..<range.upperBound.value))
    }
    
    /// See [`FixedWidthInteger.random(in:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/3020576-random)
    public static func random<G>(in range: ClosedRange<Failable<T, Validations>>, using generator: inout G)throws
        -> Failable<T, Validations> where G : RandomNumberGenerator
    {
        return try Failable(T.random(in: range.lowerBound.value...range.upperBound.value, using: &generator))
    }
    
    /// See [`FixedWidthInteger.random(in:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/3020578-random)
    public static func random<G>(in range: Range<Failable<T, Validations>>, using generator: inout G)throws
        -> Failable<T, Validations> where G : RandomNumberGenerator
    {
        return try Failable(T.random(in: range.lowerBound.value..<range.upperBound.value, using: &generator))
    }
    
    
    // MARK: - Operators
    
    /// See [`FixedWidthInteger.&*(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884714).
    public static func &* (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value &* rhs.value)
    }
    
    /// See [`FixedWidthInteger.&*=(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2995497).
    public static func &*= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs &* rhs
    }
    
    /// See [`FixedWidthInteger.&+(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884804).
    public static func &+ (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value &+ rhs.value)
    }
    
    /// See [`FixedWidthInteger.&+=(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2995499).
    public static func &+= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs &+ rhs
    }
    
    /// See [`FixedWidthInteger.&-(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884345-_).
    public static func &- (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value &- rhs.value)
    }
    
    /// See [`FixedWidthInteger.&-=(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2995501-_).
    public static func &-= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs &- rhs
    }
    
    /// See [`FixedWidthInteger.&<<(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964298).
    public static func &<< (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value &<< rhs.value)
    }
    
    /// See [`FixedWidthInteger.&<<=(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2925973).
    public static func &<<= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs &<< rhs
    }
    
    /// See [`FixedWidthInteger.&>>(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2964304).
    public static func &>> (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value &>> rhs.value)
    }
    
    /// See [`FixedWidthInteger.&>>=(_:_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2924977).
    public static func &>>= (lhs: inout Failable<T, Validations>, rhs: Failable<T, Validations>)throws {
        try lhs = lhs &>> rhs
    }
}


/// Returns the product of the two given `Failable` values, wrapping the result in case of any overflow.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to mutiply.
///
/// - Returns: The product of the multiplcation equation, with validation types from the values passed in mixed.
public func &* <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FixedWidthInteger
{
    return try Failable(lhs.value &* rhs.value)
}

/// Returns the sum of the two given values, wrapping the result in case of any overflow.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
///
/// - Returns: The sum of the addition equation, with validation types from the values passed in mixed.
public func &+ <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FixedWidthInteger
{
    return try Failable(lhs.value &+ rhs.value)
}

/// Returns the difference of the two given values, wrapping the result in case of any overflow.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract from the left value.
///
/// - Returns: The difference of the subtraction equation, with validation types from the values passed in mixed.
public func &- <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FixedWidthInteger
{
    return try Failable(lhs.value &- rhs.value)
}

/// Returns the result of shifting a value’s binary representation the specified number of digits to the left,
/// masking the shift amount to the type’s bit width.
///
/// - Parameters:
///   - lhs: The value to shift.
///   - rhs: The amount to shift the left value by.
///
/// - Returns: The result of the shift operation, with validation types from the values passed in mixed.
public func &<< <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FixedWidthInteger
{
    return try Failable(lhs.value &<< rhs.value)
}

/// Returns the result of shifting a value’s binary representation the specified number of digits to the right,
/// masking the shift amount to the type’s bit width.
///
/// - Parameters:
///   - lhs: The value to shift.
///   - rhs: The amount to shift the left value by.
///
/// - Returns: The result of the shift operation, with validation types from the values passed in mixed.
public func &>> <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FixedWidthInteger
{
    return try Failable(lhs.value &>> rhs.value)
}
