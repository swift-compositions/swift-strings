#if os(Windows)

    public import String

    extension Array where Element == String.String.Char {

        @inlinable
        public var utf8Bytes: [UInt8] {
            [UInt8](Swift.String(decoding: self, as: UTF16.self).utf8)
        }

        @inlinable
        public func appendUTF8<Buffer: RangeReplaceableCollection>(
            into buffer: inout Buffer
        ) where Buffer.Element == UInt8 {
            buffer.append(contentsOf: Swift.String(decoding: self, as: UTF16.self).utf8)
        }
    }

#endif
