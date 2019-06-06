extension Validated: UnsignedInteger where T: UnsignedInteger { }

extension Validated: SignedInteger where T: SignedInteger { }

extension Validated: FixedWidthInteger where T: FixedWidthInteger {
    /// See [`FixedWidthInteger.bitWidth`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2886552-bitwidth).
    public static var bitWidth: Int {
        return T.bitWidth
    }

    /// See [`FixedWidthInteger.min`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884515-min).
    public static var min: Validated<T, Validations> {
        return Validated(initialValue: T.min)
    }

    /// See [`FixedWidthInteger.max`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2883788-max).
    public static var max: Validated<T, Validations> {
        return Validated(initialValue: T.max)
    }

    /// See [`FixedWidthInteger.nonzeroBitCount`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885911-nonzerobitcount).
    public var nonzeroBitCount: Int {
        return self.value?.nonzeroBitCount ?? 0
    }

    /// See [`FixedWidthInteger.leadingZeroBitCount`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2883995-leadingzerobitcount).
    public var leadingZeroBitCount: Int {
        return self.value?.leadingZeroBitCount ?? 0
    }

    /// See [`FixedWidthInteger.byteSwapped`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884324-byteswapped).
    public var byteSwapped: Validated<T, Validations> {
        return self.map { $0.byteSwapped }
    }

    /// I don't know what this initializer is for. The `FixedWidthInteger` requires it,
    /// but I can't find the documentation. Here's a unicorn instead: 🦄
    public init<BI>(_truncatingBits truncatingBits: BI) where BI : BinaryInteger {
        self = Validated(initialValue: T(truncatingBits))
    }

    /// See [`FixedWidthInteger.addingReportingOverflow(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885260-addingreportingoverflow).
    public func addingReportingOverflow(_ rhs: Validated<T, Validations>)
        -> (partialValue: Validated<T, Validations>, overflow: Bool)
    {
        let result: AlwaysValidated<(T, Bool)> = Validated.map(self, rhs) { left, right in
            return left.addingReportingOverflow(right)
        }

        let overflow: AlwaysValidated<Bool> = result.map { $0.1 }
        return (partialValue: result.map { $0.0 }, overflow: overflow.value ?? false)
    }

    /// See [`FixedWidthInteger.subtractingReportingOverflow(_:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885098-subtractingreportingoverflow).
    public func subtractingReportingOverflow(_ rhs: Validated<T, Validations>)
        -> (partialValue: Validated<T, Validations>, overflow: Bool)
    {
        let result: AlwaysValidated<(T, Bool)> = Validated.map(self, rhs) { left, right in
            return left.subtractingReportingOverflow(right)
        }

        let overflow: AlwaysValidated<Bool> = result.map { $0.1 }
        return (partialValue: result.map { $0.0 }, overflow: overflow.value ?? false)
    }

    /// See [`FixedWidthInteger.multipliedReportingOverflow(by:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884864-multipliedreportingoverflow).
    public func multipliedReportingOverflow(by rhs: Validated<T, Validations>)
        -> (partialValue: Validated<T, Validations>, overflow: Bool)
    {
        let result: AlwaysValidated<(T, Bool)> = Validated.map(self, rhs) { left, right in
            return left.multipliedReportingOverflow(by: right)
        }

        let overflow: AlwaysValidated<Bool> = result.map { $0.1 }
        return (partialValue: result.map { $0.0 }, overflow: overflow.value ?? false)
    }

    /// See [`FixedWidthInteger.dividedReportingOverflow(by:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2885588-dividedreportingoverflow).
    public func dividedReportingOverflow(by rhs: Validated<T, Validations>)
        -> (partialValue: Validated<T, Validations>, overflow: Bool)
    {
        let result: AlwaysValidated<(T, Bool)> = Validated.map(self, rhs) { left, right in
            return left.dividedReportingOverflow(by: right)
        }

        let overflow: AlwaysValidated<Bool> = result.map { $0.1 }
        return (partialValue: result.map { $0.0 }, overflow: overflow.value ?? false)
    }

    /// See [`FixedWidthInteger.remainderReportingOverflow(dividingBy:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2892758-remainderreportingoverflow).
    public func remainderReportingOverflow(dividingBy rhs: Validated<T, Validations>)
        -> (partialValue: Validated<T, Validations>, overflow: Bool)
    {
        let result: AlwaysValidated<(T, Bool)> = Validated.map(self, rhs) { left, right in
            return left.remainderReportingOverflow(dividingBy: right)
        }

        let overflow: AlwaysValidated<Bool> = result.map { $0.1 }
        return (partialValue: result.map { $0.0 }, overflow: overflow.value ?? false)
    }

    /// See [`FixedWidthInteger.multipliedFullWidth(by:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884581-multipliedfullwidth).
    public func multipliedFullWidth(by other: Validated<T, Validations>)
        -> (high: Validated<T, Validations>, low: Validated<T.Magnitude, MagnitudeValidation<T.Magnitude>>)
    {
        let results: AlwaysValidated<(T, T.Magnitude)> = Validated.map(self, other) { left, right in
            return left.multipliedFullWidth(by: right)
        }

        return (results.map { $0.0 }, results.map { $0.1 })
    }

    /// See [`FixedWidthInteger.dividingFullWidth(dividend:)`](https://developer.apple.com/documentation/swift/fixedwidthinteger/2884055-dividingfullwidth).
    public func dividingFullWidth(
        _ dividend: (high: Validated<T, Validations>, low: Validated<T.Magnitude, MagnitudeValidation<T.Magnitude>>)
    ) -> (quotient: Validated<T, Validations>, remainder: Validated<T, Validations>) {
        switch (self, dividend.high, dividend.low) {
        case let (.value(l), .value(high), .value(low)):
            let result = l.dividingFullWidth((high, low))
            return (Validated(initialValue: result.quotient), Validated(initialValue: result.remainder))
        case let (_, .error(left), .error(right)):
            let error = ValidationError.foundError(ErrorJoin(left, right))
            return (.error(error), .error(error))
        case (.error(let err), _, _), (_, .error(let err), _), (_, _, .error(let err)):
            let error = ValidationError.foundError(err)
            return (.error(error), .error(error))
        }
    }
}

extension Validated: BinaryInteger where T: BinaryInteger {
    /// See [`BinaryInteger.Words`](https://developer.apple.com/documentation/swift/binaryinteger/2894610-words).
    public typealias Words = Array<UInt>

    /// See [`BinaryInteger.bitWidth`](https://developer.apple.com/documentation/swift/binaryinteger/2886690-bitwidth).
    public var bitWidth: Int {
        return self.value?.bitWidth ?? 0
    }

    /// See [`BinaryInteger.init(_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885704-init).
    public init<BI>(_ source: BI) where BI: BinaryInteger {
        self = Validated(initialValue: T(source))
    }

    /// See [`BinaryInteger.init(_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884166-init).
    public init<BFP>(_ source: BFP) where BFP : BinaryFloatingPoint {
        self = Validated(initialValue: T(source))
    }

    /// See [`BinaryInteger.init(clamping:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886143-init).
    public init<BI>(clamping source: BI) where BI: BinaryInteger {
        self = Validated(initialValue: T(clamping: source))
    }

    /// See [`BinaryInteger.init(exactly:)`](https://developer.apple.com/documentation/swift/binaryinteger/2925955-init).
    public init?<BFP>(exactly source: BFP) where BFP : BinaryFloatingPoint {
        guard let value = T(exactly: source) else { return nil }
        self = Validated(initialValue: value)
    }

    /// See [`BinaryInteger.init(truncatingIfNeeded:)`](https://developer.apple.com/documentation/swift/binaryinteger/2925529-init).
    public init<BI>(truncatingIfNeeded source: BI) where BI: BinaryInteger {
        let t = T(truncatingIfNeeded: source)
        self = Validated(initialValue: t)
    }

    /// See [`BinaryInteger.isSigned`](https://developer.apple.com/documentation/swift/binaryinteger/2886485-issigned).
    public static var isSigned: Bool {
        return T.isSigned
    }

    /// See [`BinaryInteger.words`](https://developer.apple.com/documentation/swift/binaryinteger/2892492-words).
    public var words: Words {
        return (self.value?.words).map(Array<UInt>.init) ?? []
    }

    /// See [`BinaryInteger.trailingZeroBitCount`](https://developer.apple.com/documentation/swift/binaryinteger/2886715-trailingzerobitcount).
    public var trailingZeroBitCount: Int {
        return self.value?.trailingZeroBitCount ?? 0
    }

    /// See [`BinaryInteger.~(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884248).
    public prefix static func ~ (value: Validated<T, Validations>) -> Validated<T, Validations> {
        return value.map { ~$0 }
    }

    /// See [`BinaryInteger./(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885552).
    public static func / (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in return left / right }
    }

    /// See [`BinaryInteger./=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885191).
    public static func /= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs / rhs
    }

    /// See [`BinaryInteger.%(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885003).
    public static func % (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in return left % right }
    }

    /// See [`BinaryInteger.%=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886158).
    public static func %= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs % rhs
    }

    /// See [`BinaryInteger.&(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017613).
    public static func & (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in return left & right }
    }

    /// See [`BinaryInteger.&=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885976).
    public static func &= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs & rhs
    }

    /// See [`BinaryInteger.|(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017645).
    public static func | (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in return left | right }
    }

    /// See [`BinaryInteger.|=(_:_:)`]().
    public static func |= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs | rhs
    }

    /// See [`BinaryInteger.^(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884669).
    public static func ^ (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in return left ^ right }
    }

    /// See [`BinaryInteger.^=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017635).
    public static func ^= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs ^ rhs
    }

    /// See [`BinaryInteger.>>=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2926011).
    public static func >>= <RHS>(lhs: inout Validated<T, Validations>, rhs: RHS) where RHS : BinaryInteger {
        lhs = lhs.map { $0 >> rhs }
    }

    /// See [`BinaryInteger.<<=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2926303).
    public static func <<= <RHS>(lhs: inout Validated<T, Validations>, rhs: RHS) where RHS : BinaryInteger {
        lhs = lhs.map { $0 << rhs }
    }
}

/// See [`BinaryInteger.%(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885003).
public func % <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: BinaryInteger
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left % right }
}

/// See [`BinaryInteger.&(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017613).
public func & <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: BinaryInteger
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left & right }
}

/// See [`BinaryInteger.<(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885984).
public func < <T, V1, Other>(lhs: Validated<T, V1>, rhs: Other) -> Bool
    where T: BinaryInteger, Other: BinaryInteger
{
    switch lhs {
    case let .value(value): return value < rhs
    case .error: return false
    }
}

/// See [`BinaryInteger.^(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017635).
public func ^ <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: BinaryInteger
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left ^ right }
}

/// See [`BinaryInteger.|(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/3017645).
public func | <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: BinaryInteger
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left | right }
}

/// See [`BinaryInteger.%=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2886158).
public func %= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: BinaryInteger {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left % right }
}

/// See [`BinaryInteger.&=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885976).
public func &= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: BinaryInteger {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left & right }
}

/// See [`BinaryInteger.^=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2885182).
public func ^= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: BinaryInteger {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left ^ right }
}

/// See [`BinaryInteger.|=(_:_:)`](https://developer.apple.com/documentation/swift/binaryinteger/2884669).
public func |= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: BinaryInteger {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left | right }
}
