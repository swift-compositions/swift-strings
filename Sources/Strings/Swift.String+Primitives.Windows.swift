#if os(Windows)

    public import String

    extension Swift.String {

        @inlinable
        public init(_ view: borrowing String.String.Borrowed) {
            let units = unsafe Array(UnsafeBufferPointer(start: view.pointer, count: view.count))
            self = Swift.String.lossyUTF16(units)
        }

        @inlinable
        public init(_ owned: consuming String.String) {
            let units = unsafe Array(
                UnsafeBufferPointer(start: owned.view.pointer, count: owned.view.count)
            )
            self = Swift.String.lossyUTF16(units)
        }
    }

    extension String.String {

        @inlinable
        public init(_ string: Swift.String) {
            let contentLength = string.utf16.count
            let utf16 = Array(string.utf16) + [0]
            let buffer = UnsafeMutablePointer<String.String.Char>.allocate(
                capacity: utf16.count
            )
            for (i, unit) in utf16.enumerated() {
                buffer[i] = unit
            }
            self.init(adopting: buffer, count: contentLength)
        }
    }

    extension Swift.String {

        @_optimize(none)
        @inlinable
        public func withPrimitivesView<R: ~Copyable, E: Swift.Error>(
            _ body: (borrowing String.String.Borrowed) throws(E) -> R
        ) throws(E) -> R {
            let utf16Array = Array(self.utf16)
            let count = utf16Array.count
            let buffer = UnsafeMutablePointer<String.String.Char>.allocate(
                capacity: count + 1
            )
            defer { buffer.deallocate() }
            for (i, unit) in utf16Array.enumerated() {
                buffer[i] = unit
            }
            buffer[count] = 0
            let view = String.String.Borrowed(UnsafePointer(buffer), count: count)
            return try body(view)
        }
    }

#endif
