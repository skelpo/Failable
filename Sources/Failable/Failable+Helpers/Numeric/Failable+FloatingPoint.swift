// TODO: Try to remove `Validations == MagnitudeValidation<T>` constraint.
extension Validated: FloatingPoint where T: FloatingPoint, Validations == MagnitudeValidation<T> {
    /// See [`FloatingPoint.Exponent`](https://developer.apple.com/documentation/swift/floatingpoint/1848224-exponent).
    public typealias Exponent = AlwaysValidated<T.Exponent>

    /// See [`FloatingPoint.nan`](https://developer.apple.com/documentation/swift/floatingpoint/1641652-nan).
    public static var nan: Validated<T, Validations> {
        return Validated(initialValue: T.nan)
    }

    /// See [`FloatingPoint.signalingNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1845864-signalingnan).
    public static var signalingNaN: Validated<T, Validations> {
        return Validated(initialValue: T.signalingNaN)
    }

    /// See [`FloatingPoint.infinity`](https://developer.apple.com/documentation/swift/floatingpoint/1641304-infinity).
    public static var infinity: Validated<T, Validations> {
        return Validated(initialValue: T.infinity)
    }

    /// See [`FloatingPoint.greatestFiniteMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1849534-greatestfinitemagnitude).
    public static var greatestFiniteMagnitude: Validated<T, Validations> {
        return Validated(initialValue: T.greatestFiniteMagnitude)
    }

    /// See [`FloatingPoint.pi`](https://developer.apple.com/documentation/swift/floatingpoint/1845454-pi).
    public static var pi: Validated<T, Validations> {
        return Validated(initialValue: T.pi)
    }

    /// See [`FloatingPoint.leastNormalMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1849504-leastnormalmagnitude).
    public static var leastNormalMagnitude: Validated<T, Validations> {
        return Validated(initialValue: T.leastNormalMagnitude)
    }

    /// See [`FloatingPoint.leastNonzeroMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1848591-leastnonzeromagnitude).
    public static var leastNonzeroMagnitude: Validated<T, Validations> {
        return Validated(initialValue: T.leastNonzeroMagnitude)
    }


    /// See [`FloatingPoint.radix`](https://developer.apple.com/documentation/swift/floatingpoint/1846156-radix).
    public static var radix: Int {
        return T.radix
    }

    /// See [`FloatingPoint.ulp`](https://developer.apple.com/documentation/swift/floatingpoint/1847492-ulp).
    public var ulp: Validated<T, Validations> {
        return self[keyPath: \.ulp]
    }

    /// See [`FloatingPoint.sign`](https://developer.apple.com/documentation/swift/floatingpoint/1847735-sign).
    public var sign: FloatingPointSign {
        return self.value?.sign ?? .plus
    }

    /// See [`FloatingPoint.exponent`](https://developer.apple.com/documentation/swift/floatingpoint/1846275-exponent).
    public var exponent: Exponent {
        return self.map { $0.exponent }
    }

    /// See [`FloatingPoint.significand`](https://developer.apple.com/documentation/swift/floatingpoint/1847298-significand).
    public var significand: Validated<T, Validations> {
        return self.map { $0.significand }
    }

    /// See [`FloatingPoint.nextUp`](https://developer.apple.com/documentation/swift/floatingpoint/1848104-nextup).
    public var nextUp: Validated<T, Validations> {
        return self.map { $0.nextUp }
    }

    /// See [`FloatingPoint.isNormal`](https://developer.apple.com/documentation/swift/floatingpoint/1641394-isnormal).
    public var isNormal: Bool {
        return self.value?.isNormal ?? false
    }

    /// See [`FloatingPoint.isFinite`](https://developer.apple.com/documentation/swift/floatingpoint/1641190-isfinite).
    public var isFinite: Bool {
        return self.value?.isFinite ?? false
    }

    /// See [`FloatingPoint.isZero`](https://developer.apple.com/documentation/swift/floatingpoint/1641514-iszero).
    public var isZero: Bool {
        return self.value?.isZero ?? false
    }

    /// See [`FloatingPoint.isSubnormal`](https://developer.apple.com/documentation/swift/floatingpoint/1641181-issubnormal).
    public var isSubnormal: Bool {
        return self.value?.isSubnormal ?? false
    }

    /// See [`FloatingPoint.isInfinite`](https://developer.apple.com/documentation/swift/floatingpoint/1641669-isinfinite).
    public var isInfinite: Bool {
        return self.value?.isInfinite ?? false
    }

    /// See [`FloatingPoint.isNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1641763-isnan).
    public var isNaN: Bool {
        return self.value?.isNaN ?? false
    }

    /// See [`FloatingPoint.isSignalingNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1847971-issignalingnan).
    public var isSignalingNaN: Bool {
        return self.value?.isSignalingNaN ?? false
    }

    /// See [`FloatingPoint.isCanonical`](https://developer.apple.com/documentation/swift/floatingpoint/1847929-iscanonical).
    public var isCanonical: Bool {
        return self.value?.isCanonical ?? false
    }


    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641560-init).
    public init(_ value: Int) {
        self = Validated(initialValue: T(value))
    }

    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2964416-init).
    public init<Source>(_ value: Source) where Source : BinaryInteger {
        self = Validated(initialValue: T(value))
    }

    /// See [`FloatingPoint.init(sign:exponent:significand:`](https://developer.apple.com/documentation/swift/floatingpoint/1845755-init).
    public init(sign: FloatingPointSign, exponent: Exponent, significand: Validated<T, Validations>) {
        self = Validated.map(exponent, significand) { exp, sig in T(sign: sign, exponent: exp, significand: sig)}
    }

    /// See [`FloatingPoint.init(signOf:magnitudeOf:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849294-init).
    public init(signOf sign: Validated<T, Validations>, magnitudeOf maginitude: Validated<T, Validations>) {
        self = Validated.map(sign, maginitude, closure: T.init(signOf:magnitudeOf:))
    }


    /// See [`FloatingPoint.*(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2886135).
    public static func * (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in left * right }
    }

    /// See [`FloatingPoint.*=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2885700).
    public static func *= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs * rhs
    }

    /// See [`FloatingPoint./(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884057).
    public static func / (lhs: Validated<T, Validations>, rhs: Validated<T, Validations>) -> Validated<T, Validations> {
        return Validated.map(lhs, rhs) { left, right in left / right }
    }

    /// See [`FloatingPoint./=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2886632).
    public static func /= (lhs: inout Validated<T, Validations>, rhs: Validated<T, Validations>) {
        lhs = lhs / rhs
    }

    /// See [`FloatingPoint.round(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2298113-round).
    public mutating func round(_ rule: FloatingPointRoundingRule) {
        self = self.map { value in value.rounded(rule) }
    }

    /// See [`FloatingPoint.formRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/2299459-formremainder).
    public mutating func formRemainder(dividingBy other: Validated<T, Validations>) {
        self = Validated.map(self, other) { left, right in
            var result = left
            result.formRemainder(dividingBy: right)
            return result
        }
    }

    /// See [`FloatingPoint.formTruncatingRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846470-formtruncatingremainder).
    public mutating func formTruncatingRemainder(dividingBy other: Validated<T, Validations>) {
        self = Validated.map(self, other) { left, right in
            var result = left
            result.formTruncatingRemainder(dividingBy: right)
            return result
        }
    }

    /// See [`FloatingPoint.formSquareRoot()`](https://developer.apple.com/documentation/swift/floatingpoint/2299104-formsquareroot).
    public mutating func formSquareRoot() {
        self = self.map { value in
            var result = value
            result.formSquareRoot()
            return result
        }
    }

    /// See [`FloatingPoint.addProduct(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2295205-addproduct).
    public mutating func addProduct(_ lhs: Validated<T, Validations>, _ rhs: Validated<T, Validations>) {
        self = self.map { value in
            var result = value
            let _: AlwaysValidated<()> = try Validated.map(lhs, rhs) { left, right in
                result.addProduct(left, right)
            }.validate()
            return result
        }
    }

    /// See [`FloatingPoint.isEqual(to:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846385-isequal).
    public func isEqual(to other: Validated<T, Validations>) -> Bool {
        return self == other
    }

    /// See [`FloatingPoint.isLess(than:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849403-isless).
    public func isLess(than other: Validated<T, Validations>) -> Bool {
        return self < other
    }

    /// See [`FloatingPoint.isLessThanOrEqualTo(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849007-islessthanorequalto).
    public func isLessThanOrEqualTo(_ other: Validated<T, Validations>) -> Bool {
        return self <= other
    }

    /// See [`FloatingPoint.isTotallyOrdered(belowOrEqualTo:)`](https://developer.apple.com/documentation/swift/floatingpoint/2428057-istotallyordered).
    public func isTotallyOrdered(belowOrEqualTo other: Validated<T, MagnitudeValidation<T>>) -> Bool {
        let ordered: AlwaysValidated<Bool> = Validated.map(self, other) { left, right -> Bool in
            return left.isTotallyOrdered(belowOrEqualTo: right)
        }

        return ordered.value ?? false
    }
}

extension Validated: BinaryFloatingPoint where T: BinaryFloatingPoint, Validations == MagnitudeValidation<T> {
    /// See [`BinaryFloatingPoint.RawSignificand`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846956-rawexponent).
    public typealias RawSignificand = AlwaysValidated<T.RawSignificand>

    /// See [`BinaryFloatingPoint.RawExponent`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1848447-rawsignificand).
    public typealias RawExponent = AlwaysValidated<T.RawExponent>

    /// See [`BinaryFloatingPoint.exponentBitCount`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1847221-exponentbitcount).
    public static var exponentBitCount: Int {
        return T.exponentBitCount
    }

    /// See [`BinaryFloatingPoint.significandBitCount`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846714-significandbitcount).
    public static var significandBitCount: Int {
        return T.significandBitCount
    }

    /// See [`BinaryFloatingPoint.significandWidth`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1847322-significandwidth).
    public var significandWidth: Int {
        return self.value?.significandWidth ?? 0
    }

    /// See [`BinaryFloatingPoint.binade`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1848292-binade).
    public var binade: Validated<T, Validations> {
        return self.map { $0.binade }
    }

    /// See [`BinaryFloatingPoint.exponentBitPattern`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1846505-exponentbitpattern).
    public var exponentBitPattern: AlwaysValidated<T.RawExponent> {
        return self.map { $0.exponentBitPattern }
    }

    /// See [`BinaryFloatingPoint.significandBitPattern`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1845838-significandbitpattern).
    public var significandBitPattern: AlwaysValidated<T.RawSignificand> {
        return self.map { $0.significandBitPattern }
    }

    /// See [`BinaryFloatingPoint.init(sign:exponentBitPattern:significandBitPattern)`](https://developer.apple.com/documentation/swift/binaryfloatingpoint/1849503-init).
    public init(sign: FloatingPointSign, exponentBitPattern expBP: RawExponent, significandBitPattern sigBP: RawSignificand) {
        self = Validated.map(expBP, sigBP) { exp, sig in T(sign: sign, exponentBitPattern: exp, significandBitPattern: sig) }
    }
}

/// See [`Numeric.*(_:_:)`](https://developer.apple.com/documentation/swift/numeric/2883821).
public func / <T, V1, V2>(lhs: Validated<T, V1>, rhs: Validated<T, V2>) -> Validated<T, AppendedValidations<V1, V2>>
    where T: FloatingPoint
{
    return Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left / right }
}

/// See [`AdditiveArithmetic.-=(_:_:)`](https://developer.apple.com/documentation/swift/additivearithmetic/3126828).
public func /= <T, V1, V2>(lhs: inout Validated<T, V1>, rhs: Validated<T, V2>) where T: FloatingPoint {
    lhs = Validated<T, V1>.map(lhs, rhs) { (left: T, right: T) -> T in left / right }
}
