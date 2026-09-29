#if !os(Windows)

    import String

    extension Array where Element == String::String.Char {

        @inlinable
        public var utf8Bytes: [UInt8] {
            self
        }

        @inlinable
        public func appendUTF8<Buffer: RangeReplaceableCollection>(
            into buffer: inout Buffer
        ) where Buffer.Element == UInt8 {
            buffer.append(contentsOf: self)
        }
    }

#endif
