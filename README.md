# swift-strings

Use this package when you move text between `Swift.String` and the null-terminated strings that system and C APIs use, or when you need to decode code units and reject invalid input instead of repairing it. It bridges `Swift.String` to the platform `String` from swift-string and to `ISO_9899.String` from swift-iso-9899, and adds `Swift.String.strictUTF8(_:)` and `Swift.String.strictUTF16(_:)`. If you only need to own or borrow a platform string, use swift-string.

## Laws

- `Swift.String.strictUTF8(_:)` and `Swift.String.strictUTF16(_:)` return nil if any part of the input is invalid: overlong forms, encoded surrogates, values above U+10FFFF, truncated sequences, stray continuation bytes, and lone or reversed surrogates. Empty input gives the empty string.
- `Swift.String.lossyUTF16(_:)` replaces each lone surrogate with U+FFFD and keeps every code unit it is given, NULs included.
- Building a `Swift.String` from a byte span throws on invalid UTF-8 instead of repairing it.
- Going from `Swift.String` to the platform `String` or `ISO_9899.String` copies the UTF-8 (UTF-16 on Windows) and adds one terminating NUL that the count leaves out.
- Going back to `Swift.String` from `ISO_9899.String`, or from the platform `String` on POSIX, reads up to the first NUL and repairs invalid UTF-8 with U+FFFD, so a string with an interior NUL comes back cut short. On Windows the platform string is read for its full count and lone surrogates become U+FFFD.
- `Swift.String.withPrimitivesView(_:)` and `Swift.String.withISO9899View(_:)` hand the closure a NUL-terminated copy that is freed when the closure returns.
- `Swift.String.strict(platformNative:)` and `Swift.String.lossy(platformNative:)` decode as UTF-8 on POSIX and as UTF-16 on Windows.
- `Swift.Array.platformNativeHex(uppercase:)`, on an array of platform code units, writes two hex digits per byte on POSIX and four per UTF-16 code unit on Windows, most significant digit first. On Windows, `Swift.Array.utf8Bytes` transcodes the code units and repairs lone surrogates.
