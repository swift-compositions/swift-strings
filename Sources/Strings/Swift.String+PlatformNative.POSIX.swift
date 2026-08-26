#if !os(Windows)

    public import String

    extension Swift.String {

        @inlinable
        public static func strict(
            platformNative codeUnits: [String.String.Char]
        ) -> Swift.String? {
            Self.strictUTF8(codeUnits)
        }

        @inlinable
        public static func lossy(
            platformNative codeUnits: [String.String.Char]
        ) -> Swift.String {
            Swift.String(decoding: codeUnits, as: UTF8.self)
        }
    }

#endif
