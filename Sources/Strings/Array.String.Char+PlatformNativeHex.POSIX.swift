#if !os(Windows)

    import String
    public import ASCII

    extension Array where Element == String.String.Char {

        @inlinable
        public func platformNativeHex(uppercase: Bool = true) -> Swift.String {

            if uppercase {
                let digits: [UInt8] = [
                    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
                    0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46,
                ]
                var result: [UInt8] = []
                result.reserveCapacity(count * 2)
                for byte in self {
                    result.append(digits[Int(byte >> 4)])
                    result.append(digits[Int(byte & 0xF)])
                }
                return Swift.String(decoding: result, as: UTF8.self)
            }

            let serializer = ASCII.Hexadecimal.Serializer<String.String.Char>()
            var codes: [ASCII.Code] = []
            codes.reserveCapacity(count * 2)
            for byte in self {
                serializer.serialize(byte >> 4, into: &codes)
                serializer.serialize(byte & 0xF, into: &codes)
            }
            return Swift.String(decoding: codes.map(\.underlying), as: UTF8.self)
        }
    }

#endif
