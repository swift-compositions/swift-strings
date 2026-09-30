import Strings
import Testing

@Suite
struct `Strict decode boundaries` {
    @Test
    func `valid UTF-8 up to the last scalar decodes`() {
        #expect(Swift.String.strictUTF8([]) == "")
        #expect(Swift.String.strictUTF8([0x41, 0xC3, 0xA9]) == "Aé")
        #expect(Swift.String.strictUTF8([0xF4, 0x8F, 0xBF, 0xBF]) == "\u{10FFFF}")
    }

    @Test(arguments: [
        [0xC0, 0xAF] as [UInt8],
        [0xE0, 0x80, 0xAF],
        [0xED, 0xA0, 0x80],
        [0xF4, 0x90, 0x80, 0x80],
        [0xE2, 0x82],
        [0x80],
        [0xFF],
    ])
    func `invalid UTF-8 is rejected`(_ bytes: [UInt8]) {
        #expect(Swift.String.strictUTF8(bytes) == nil)
    }

    @Test
    func `valid UTF-16 decodes including a surrogate pair`() {
        #expect(Swift.String.strictUTF16([0x0041, 0xD83D, 0xDE00]) == "A😀")
    }

    @Test(arguments: [[0xD83D] as [UInt16], [0xDE00], [0xDE00, 0xD83D], [0xD83D, 0x0041]])
    func `lone or reversed surrogates are rejected in UTF-16`(_ units: [UInt16]) {
        #expect(Swift.String.strictUTF16(units) == nil)
    }
}
