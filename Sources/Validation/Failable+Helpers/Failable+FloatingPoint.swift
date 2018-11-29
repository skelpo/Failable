extension Failable where T: FloatingPoint {
    
    // MARK: - Typealiases
    
    /// See [`FloatingPoint.Exponent`](https://developer.apple.com/documentation/swift/floatingpoint/1848224-exponent).
    public typealias Exponent = T.Exponent
    
    
    // MARK: - Initializers
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641558-init).
    public init(_ value: Int8)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641150-init).
    public init(_ value: Int16)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641192-init).
    public init(_ value: Int32)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641208-init).
    public init(_ value: Int64)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641277-init).
    public init(_ value: UInt8)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641505-init).
    public init(_ value: UInt16)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641406-init).
    public init(_ value: UInt32)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641403-init).
    public init(_ value: UInt64)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641530-init).
    public init(_ value: UInt)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1641560-init).
    public init(_ value: Int)throws {
        let t = T(value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(exactly:)`](https://developer.apple.com/documentation/swift/floatingpoint/2964416-init).
    public init?<Source>(exactly value: Source) where Source : BinaryInteger {
        guard let t = T(exactly: value) else { return nil }
        try? self.init(t)
    }
    
    /// See [`FloatingPoint.init(sign:exponent:significand:)`](https://developer.apple.com/documentation/swift/floatingpoint/1845755-init).
    public init(sign: FloatingPointSign, exponent: Exponent, significand: Failable<T, Validations>)throws {
        let t = T(sign: sign, exponent: exponent, significand: significand.value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(signOf:magnitudeOf:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849294-init).
    public init(signOf: Failable<T, Validations>, magnitudeOf: Failable<T, Validations>)throws {
        let t = T(signOf: signOf.value, magnitudeOf: magnitudeOf.value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(sign:exponent:significand:)`](https://developer.apple.com/documentation/swift/floatingpoint/1845755-init).
    public init<V>(sign: FloatingPointSign, exponent: Exponent, significand: Failable<T, V>)throws {
        let t = T(sign: sign, exponent: exponent, significand: significand.value)
        try self.init(t)
    }
    
    /// See [`FloatingPoint.init(signOf:magnitudeOf:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849294-init).
    public init<V1, V2>(signOf: Failable<T, V1>, magnitudeOf: Failable<T, V2>)throws {
        let t = T(signOf: signOf.value, magnitudeOf: magnitudeOf.value)
        try self.init(t)
    }
    
    
    // MARK: - Properties
    
    /// See [`FloatingPoint.exponent`](https://developer.apple.com/documentation/swift/floatingpoint/1846275-exponent).
    public var exponent: Exponent {
        return self.value.exponent
    }
    
    /// See [`FloatingPoint.floatingPointClass`](https://developer.apple.com/documentation/swift/floatingpoint/3017961-floatingpointclass).
    public var floatingPointClass: FloatingPointClassification {
        return self.value.floatingPointClass
    }
    
    /// See [`FloatingPoint.isCanonical`](https://developer.apple.com/documentation/swift/floatingpoint/1847929-iscanonical).
    public var isCanonical: Bool {
        return self.value.isCanonical
    }
    
    /// See [`FloatingPoint.isFinite`](https://developer.apple.com/documentation/swift/floatingpoint/1641190-isfinite).
    public var isFinite: Bool {
        return self.value.isFinite
    }
    
    /// See [`FloatingPoint.isInfinite`](https://developer.apple.com/documentation/swift/floatingpoint/1641669-isinfinite).
    public var isInfinite: Bool {
        return self.value.isInfinite
    }
    
    /// See [`FloatingPoint.isNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1641763-isnan).
    public var isNaN: Bool {
        return self.value.isNaN
    }
    
    /// See [`FloatingPoint.isNormal`](https://developer.apple.com/documentation/swift/floatingpoint/1641394-isnormal).
    public var isNormal: Bool {
        return self.value.isNormal
    }
    
    /// See [`FloatingPoint.isSignalingNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1847971-issignalingnan).
    public var isSignalingNaN: Bool {
        return self.value.isSignalingNaN
    }
    
    /// See [`FloatingPoint.isSubnormal`](https://developer.apple.com/documentation/swift/floatingpoint/1641181-issubnormal).
    public var isSubnormal: Bool {
        return self.value.isSubnormal
    }
    
    /// See [`FloatingPoint.isZero`](https://developer.apple.com/documentation/swift/floatingpoint/1641514-iszero).
    public var isZero: Bool {
        return self.value.isZero
    }
    
    /// See [`FloatingPoint.nextDown`](https://developer.apple.com/documentation/swift/floatingpoint/3017979-nextdown).
    public var nextDown: Failable<T, Validations> {
        return try! Failable(self.value.nextDown)
    }
    
    /// See [`FloatingPoint.nextUp`](https://developer.apple.com/documentation/swift/floatingpoint/1848104-nextup).
    public var nextUp: Failable<T, Validations> {
        return try! Failable(self.value.nextUp)
    }
    
    /// See [`FloatingPoint.sign`](https://developer.apple.com/documentation/swift/floatingpoint/1847735-sign).
    public var sign: FloatingPointSign {
        return self.value.sign
    }
    
    /// See [`FloatingPoint.significand`](https://developer.apple.com/documentation/swift/floatingpoint/1847298-significand).
    public var significand: Failable<T, Validations> {
        return try! Failable(self.value.significand)
    }
    
    /// See [`FloatingPoint.ulp`](https://developer.apple.com/documentation/swift/floatingpoint/1847492-ulp).
    public var ulp: Failable<T, Validations> {
        return try! Failable(self.value.ulp)
    }
    
    
    // MARK: - Static Properties
    
    /// See [`FloatingPoint.greatestFiniteMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1849534-greatestfinitemagnitude).
    public static var greatestFiniteMagnitude: Failable<T, Validations> {
        return try! Failable(T.greatestFiniteMagnitude)
    }
    
    /// See [`FloatingPoint.infinity`](https://developer.apple.com/documentation/swift/floatingpoint/1641304-infinity).
    public static var infinity: Failable<T, Validations> {
        return try! Failable(T.infinity)
    }
    
    /// See [`FloatingPoint.leastNonzeroMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1848591-leastnonzeromagnitude).
    public static var leastNonzeroMagnitude: Failable<T, Validations> {
        return try! Failable(T.leastNonzeroMagnitude)
    }
    
    /// See [`FloatingPoint.leastNormalMagnitude`](https://developer.apple.com/documentation/swift/floatingpoint/1849504-leastnormalmagnitude).
    public static var leastNormalMagnitude: Failable<T, Validations> {
        return try! Failable(T.leastNormalMagnitude)
    }
    
    /// See [`FloatingPoint.nan`](https://developer.apple.com/documentation/swift/floatingpoint/1641652-nan).
    public static var nan: Failable<T, Validations> {
        return try! Failable(T.nan)
    }
    
    /// See [`FloatingPoint.pi`](https://developer.apple.com/documentation/swift/floatingpoint/1845454-pi).
    public static var pi: Failable<T, Validations> {
        return try! Failable(T.pi)
    }
    
    /// See [`FloatingPoint.radix`](https://developer.apple.com/documentation/swift/floatingpoint/1846156-radix).
    public static var radix: Failable<T, Validations> {
        return try! Failable(T.radix)
    }
    
    /// See [`FloatingPoint.signalingNaN`](https://developer.apple.com/documentation/swift/floatingpoint/1845864-signalingnan).
    public static var signalingNaN: Failable<T, Validations> {
        return try! Failable(T.signalingNaN)
    }
    
    /// See [`FloatingPoint.ulpOfOne`](https://developer.apple.com/documentation/swift/floatingpoint/3017999-ulpofone).
    public static var ulpOfOne: Failable<T, Validations> {
        return try! Failable(T.ulpOfOne)
    }
    
    
    // MARK: - Instance Methods
    
    /// See [`FloatingPoint.addProduct(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2295205-addproduct).
    public mutating func addProduct(_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>) {
        self.value.addProduct(lhs.value, rhs.value)
    }
    
    /// See [`FloatingPoint.addingProduct(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017959-addingproduct).
    public func addingProduct(_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(self.value.addingProduct(lhs.value, rhs.value))
    }
    
    /// See [`FloatingPoint.formRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/2299459-formremainder).
    public mutating func formRemainder(dividingBy other: Failable<T, Validations>) {
        self.value.formRemainder(dividingBy: other.value)
    }
    
    /// See [`FloatingPoint.formSquareRoot()`](https://developer.apple.com/documentation/swift/floatingpoint/2299104-formsquareroot).
    public mutating func formSquareRoot() {
        self.value.formSquareRoot()
    }
    
    /// See [`FloatingPoint.formTruncatingRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846470-formtruncatingremainder).
    public mutating func formTruncatingRemainder(dividingBy other: Failable<T, Validations>) {
        self.value.formTruncatingRemainder(dividingBy: other.value)
    }
    
    /// See [`FloatingPoint.isEqual(to:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846385-isequal).
    public func isEqual(to other: Failable<T, Validations>) -> Bool {
        return self.value.isEqual(to: other.value)
    }
    
    /// See [`FloatingPoint.isLess(than:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849403-isless).
    public func isLess(than other: Failable<T, Validations>) -> Bool {
        return self.value.isLess(than: other.value)
    }
    
    /// See [`FloatingPoint.isLessThanOrEqualTo(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849007-islessthanorequalto).
    public func isLessThanOrEqualTo(_ other: Failable<T, Validations>) -> Bool {
        return self.value.isLessThanOrEqualTo(other.value)
    }
    
    /// See [`FloatingPoint.isTotallyOrdered(belowOrEqualTo:)`](https://developer.apple.com/documentation/swift/floatingpoint/2428057-istotallyordered).
    public func isTotallyOrdered(belowOrEqualTo other: Failable<T, Validations>) -> Bool {
        return self.value.isTotallyOrdered(belowOrEqualTo: other.value)
    }
    
    /// See [`FloatingPoint.negate()`](https://developer.apple.com/documentation/swift/floatingpoint/1849560-negate).
    public mutating func negate() {
        self.value.negate()
    }
    
    /// See [`FloatingPoint.remainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017981-remainder).
    public func remainder(dividingBy other: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(self.value.remainder(dividingBy: other.value))
    }
    
    /// See [`FloatingPoint.round()`](https://developer.apple.com/documentation/swift/floatingpoint/2297801-round).
    public mutating func round() {
        self.value.round()
    }
    
    /// See [`FloatingPoint.round(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2298113-round).
    public mutating func round(_ rule: FloatingPointRoundingRule) {
        self.value.round(rule)
    }
    
    /// See [`FloatingPoint.rounded()`](https://developer.apple.com/documentation/swift/floatingpoint/2295900-rounde).
    public func rounded()throws -> Failable<T, Validations> {
        return try Failable(self.value.rounded())
    }
    
    /// See [`FloatingPoint.rounded(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017985-rounded).
    public func rounded(_ rule: FloatingPointRoundingRule)throws -> Failable<T, Validations> {
        return try Failable(self.value.rounded(rule))
    }
    
    /// See [`FloatingPoint.squareRoot()`](https://developer.apple.com/documentation/swift/floatingpoint/3017991-squareroot).
    public func squareRoot()throws -> Failable<T, Validations> {
        return try Failable(self.value.squareRoot())
    }
    
    /// See [`FloatingPoint.truncatingRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017995-truncatingremainder).
    public func truncatingRemainder(dividingBy other: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(self.value.truncatingRemainder(dividingBy: other.value))
    }
    
    // --- Validtion Flexibility ---
    
    /// See [`FloatingPoint.addProduct(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2295205-addproduct).
    public mutating func addProduct<V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>) {
        self.value.addProduct(lhs.value, rhs.value)
    }
    
    /// See [`FloatingPoint.addingProduct(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017959-addingproduct).
    public func addingProduct<V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> {
        return try Failable<T, AppendedValidations<T, V1, V2>>(self.value.addingProduct(lhs.value, rhs.value))
    }
    
    /// See [`FloatingPoint.formRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/2299459-formremainder).
    public mutating func formRemainder<V>(dividingBy other: Failable<T, V>) {
        self.value.formRemainder(dividingBy: other.value)
    }
    
    /// See [`FloatingPoint.formTruncatingRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846470-formtruncatingremainder).
    public mutating func formTruncatingRemainder<V>(dividingBy other: Failable<T, V>) {
        self.value.formTruncatingRemainder(dividingBy: other.value)
    }
    
    /// See [`FloatingPoint.isEqual(to:)`](https://developer.apple.com/documentation/swift/floatingpoint/1846385-isequal).
    public func isEqual<V>(to other: Failable<T, V>) -> Bool {
        return self.value.isEqual(to: other.value)
    }
    
    /// See [`FloatingPoint.isLess(than:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849403-isless).
    public func isLess<V>(than other: Failable<T, V>) -> Bool {
        return self.value.isLess(than: other.value)
    }
    
    /// See [`FloatingPoint.isLessThanOrEqualTo(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/1849007-islessthanorequalto).
    public func isLessThanOrEqualTo<V>(_ other: Failable<T, V>) -> Bool {
        return self.value.isLessThanOrEqualTo(other.value)
    }
    
    /// See [`FloatingPoint.isTotallyOrdered(belowOrEqualTo:)`](https://developer.apple.com/documentation/swift/floatingpoint/2428057-istotallyordered).
    public func isTotallyOrdered<V>(belowOrEqualTo other: Failable<T, V>) -> Bool {
        return self.value.isTotallyOrdered(belowOrEqualTo: other.value)
    }
    
    /// See [`FloatingPoint.remainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017981-remainder).
    public func remainder<V>(dividingBy other: Failable<T, V>)throws -> Failable<T, AppendedValidations<T, Validations, V>> {
        return try Failable<T, AppendedValidations<T, Validations, V>>(self.value.remainder(dividingBy: other.value))
    }

    // See [`FloatingPoint.truncatingRemainder(dividingBy:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017995-truncatingremainder).
    public func truncatingRemainder<V>(dividingBy other: Failable<T, V>)throws -> Failable<T, AppendedValidations<T, Validations, V>> {
        return try Failable<T, AppendedValidations<T, Validations, V>>(self.value.truncatingRemainder(dividingBy: other.value))
    }
    
    
    // MARK: - Static Methods
    
    /// See [`FloatingPoint.maximum(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017963-maximum).
    public static func maximum(_ x: Failable<T, Validations>, _ y: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(T.maximum(x.value, y.value))
    }
    
    /// See [`FloatingPoint.maximumMagnitude(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017967-maximummagnitude).
    public static func maximumMagnitude(_ x: Failable<T, Validations>, _ y: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(T.maximumMagnitude(x.value, y.value))
    }
    
    /// See [`FloatingPoint.minimum(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017971-minimum).
    public static func minimum(_ x: Failable<T, Validations>, _ y: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(T.minimum(x.value, y.value))
    }
    
    /// See [`FloatingPoint.minimumMagnitude(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017975-minimummagnitude).
    public static func minimumMagnitude(_ x: Failable<T, Validations>, _ y: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(T.minimumMagnitude(x.value, y.value))
    }
    
    
    /// See [`FloatingPoint.maximum(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017963-maximum).
    public static func maximum<V1, V2>(_ x: Failable<T, V1>, _ y: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> {
        return try Failable<T, AppendedValidations<T, V1, V2>>(T.maximum(x.value, y.value))
    }
    
    /// See [`FloatingPoint.maximumMagnitude(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017967-maximummagnitude).
    public static func maximumMagnitude<V1, V2>(_ x: Failable<T, V1>, _ y: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> {
        return try Failable<T, AppendedValidations<T, V1, V2>>(T.maximumMagnitude(x.value, y.value))
    }
    
    /// See [`FloatingPoint.minimum(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017971-minimum).
    public static func minimum<V1, V2>(_ x: Failable<T, V1>, _ y: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> {
        return try Failable<T, AppendedValidations<T, V1, V2>>(T.minimum(x.value, y.value))
    }
    
    /// See [`FloatingPoint.minimumMagnitude(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/3017975-minimummagnitude).
    public static func minimumMagnitude<V1, V2>(_ x: Failable<T, V1>, _ y: Failable<T, V2>)throws -> Failable<T, AppendedValidations<T, V1, V2>> {
        return try Failable<T, AppendedValidations<T, V1, V2>>(T.minimumMagnitude(x.value, y.value))
    }
    
    
    // MARK: - Operators
    
    /// See [`FloatingPoint.<(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2883927).
    public static func < (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value < rhs.value
    }
    
    /// See [`FloatingPoint.<=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884778).
    public static func <= (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value <= rhs.value
    }
    
    /// See [`FloatingPoint.>(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2885368).
    public static func > (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value > lhs.value
    }
    
    /// See [`FloatingPoint.>(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884837).
    public static func >= (lhs: Failable<T, Validations>, rhs: Failable<T, Validations>) -> Bool {
        return lhs.value >= lhs.value
    }
    
    /// See [`FloatingPoint.*(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2886135).
    public static func * (_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value * rhs.value)
    }
    
    /// See [`FloatingPoint.*=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2885700).
    public static func *= (_ lhs: inout Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws {
        try lhs = lhs * rhs
    }
    
    /// See [`FloatingPoint.+(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2885022).
    public static func + (_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value + rhs.value)
    }
    
    /// See [`FloatingPoint.+=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884273).
    public static func += (_ lhs: inout Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws {
        try lhs = lhs + rhs
    }
    
    /// See [`FloatingPoint.-(_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884257).
    public prefix static func - (_ x: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(-x.value)
    }
    
    /// See [`FloatingPoint.-(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2885455).
    public static func - (_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value - rhs.value)
    }
    
    /// See [`FloatingPoint.-=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884054).
    public static func -= (_ lhs: inout Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws {
        try lhs = lhs - rhs
    }
    
    /// See [`FloatingPoint./(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2884057).
    public static func / (_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws -> Failable<T, Validations> {
        return try Failable(lhs.value / rhs.value)
    }
    
    /// See [`FloatingPoint./=(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2886632).
    public static func /= (_ lhs: inout Failable<T, Validations>, _ rhs: Failable<T, Validations>)throws {
        try lhs = lhs + rhs
    }
    
    /// See [`FloatingPoint.==(_:_:)`](https://developer.apple.com/documentation/swift/floatingpoint/2919612).
    public static func == (_ lhs: Failable<T, Validations>, _ rhs: Failable<T, Validations>) -> Bool {
        return lhs.value == rhs.value
    }
}


public func < <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: FloatingPoint {
    return lhs.value < rhs.value
}

public func <= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: FloatingPoint {
    return lhs.value <= rhs.value
}

public func > <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: FloatingPoint {
    return lhs.value > lhs.value
}

public func >= <T, V1, V2>(lhs: Failable<T, V1>, rhs: Failable<T, V2>) -> Bool where T: FloatingPoint {
    return lhs.value >= lhs.value
}

/// Multiplies two `Failable` values and produces their product, rounding to a representable value.
///
/// - Parameters:
///   - lhs: The left value to multiply.
///   - rhs: The right value to multiply.
///
/// - Returns: The product of the multiplcation equation, where the validation is the validations of the two values passed in.
public func * <T, V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FloatingPoint
{
    return try Failable(lhs.value * rhs.value)
}

/// Adds two `Failable` values and produces their sum, rounding to a representable value.
///
/// - Parameters:
///   - lhs: The left value to add.
///   - rhs: The right value to add.
///
/// - Returns: The sum of the addition equation, where the validation is the validations of the two values passed in.
public func + <T, V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FloatingPoint
{
    return try Failable(lhs.value + rhs.value)
}

/// Subtracts two `Failable` values and produces their difference, rounding to a representable value.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract from the left value.
///
/// - Returns: The difference of the subtraction equation, where the validation is the validations of the two values passed in.
public func - <T, V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FloatingPoint
{
    return try Failable(lhs.value - rhs.value)
}

/// Divides two `Failable` values and produces their quotient, rounding to a representable value.
///
/// - Parameters:
///   - lhs: The value to subtract from.
///   - rhs: The value to subtract from the left value.
///
/// - Returns: The quotient of the division equation, where the validation is the validations of the two values passed in.
public func / <T, V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>)throws
    -> Failable<T, AppendedValidations<T, V1, V2>> where T: FloatingPoint
{
    return try Failable(lhs.value / rhs.value)
}

/// Returns a Boolean value indicating whether two values are equal.
///
/// - Parameters:
///   - lhs: The left value to check for equality.
///   - rhs: The right value to check for euqality.
///
/// - Returns: The boolean indicating whether the values are equal or not.
public func == <T, V1, V2>(_ lhs: Failable<T, V1>, _ rhs: Failable<T, V2>) -> Bool where T: FloatingPoint {
    return lhs.value == rhs.value
}
