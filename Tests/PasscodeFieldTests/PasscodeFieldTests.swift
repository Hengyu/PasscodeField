//
// MIT License
//
// Copyright (c) 2022-2023 hengyu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import XCTest
@testable import PasscodeField
import SwiftUI

final class PasscodeFieldTests: XCTestCase {
    func testStringToDigits() throws {
        let wrongFormat = "abc"
        XCTAssertNotEqual([Int("a"), Int("b"), Int("c")], wrongFormat.digits)

        let digits = "123"
        XCTAssertEqual([1, 2, 3], digits.digits)
    }

    func testDigitGroupNormalCase() {
        let digitGroup = DigitGroup(digits: ["1", "2", "3", "4"], upTo: 4)
        XCTAssertEqual("1234", digitGroup.concat)
        XCTAssertFalse(digitGroup.isEmpty)
        XCTAssertEqual(
            [
                DigitGroup.IndexedDigit(index: 0, digit: "1"),
                DigitGroup.IndexedDigit(index: 1, digit: "2"),
                DigitGroup.IndexedDigit(index: 2, digit: "3"),
                DigitGroup.IndexedDigit(index: 3, digit: "4")
            ],
            digitGroup.indexed
        )
        XCTAssertEqual(3, digitGroup.currentIndex)
    }

    func testDigitGroupBlankCase() {
        let digitGroup = DigitGroup(digits: [nil, nil, nil, nil], upTo: 4)
        XCTAssertEqual(DigitGroup.blank(upTo: 4), digitGroup)
        XCTAssertEqual("", digitGroup.concat)
        XCTAssertTrue(digitGroup.isEmpty)
        XCTAssertEqual(
            [
                DigitGroup.IndexedDigit(index: 0, digit: nil),
                DigitGroup.IndexedDigit(index: 1, digit: nil),
                DigitGroup.IndexedDigit(index: 2, digit: nil),
                DigitGroup.IndexedDigit(index: 3, digit: nil)
            ],
            digitGroup.indexed
        )
        XCTAssertEqual(0, digitGroup.currentIndex)
    }

    func testDigitGroupDigitsOverflowCase() {
        let digitGroup = DigitGroup(digits: ["1", "2", nil, nil, "5"], upTo: 4)
        XCTAssertEqual("12", digitGroup.concat)
        XCTAssertFalse(digitGroup.isEmpty)
        XCTAssertEqual(
            [
                DigitGroup.IndexedDigit(index: 0, digit: "1"),
                DigitGroup.IndexedDigit(index: 1, digit: "2"),
                DigitGroup.IndexedDigit(index: 2, digit: nil),
                DigitGroup.IndexedDigit(index: 3, digit: nil)
            ],
            digitGroup.indexed
        )
        XCTAssertEqual(2, digitGroup.currentIndex)
    }

    func testDigitGroupDigitsLessCase() {
        let digitGroup = DigitGroup(digits: ["1", nil, nil, nil], upTo: 5)
        XCTAssertEqual("1", digitGroup.concat)
        XCTAssertFalse(digitGroup.isEmpty)
        XCTAssertEqual(
            [
                DigitGroup.IndexedDigit(index: 0, digit: "1"),
                DigitGroup.IndexedDigit(index: 1, digit: nil),
                DigitGroup.IndexedDigit(index: 2, digit: nil),
                DigitGroup.IndexedDigit(index: 3, digit: nil),
                DigitGroup.IndexedDigit(index: 4, digit: nil)
            ],
            digitGroup.indexed
        )
        XCTAssertEqual(1, digitGroup.currentIndex)
    }

    func testSquareStyle() {
        let style: SquareStyle = .pin
        XCTAssertEqual(48, style.width)
        XCTAssertEqual(6, style.cornerRadius)
        XCTAssertEqual(2, style.borderWidth)
        XCTAssertEqual(Color.accentColor, style.highlightedColor)
    }

    func testSquareGroupStyle() {
        let style: SquareGroupStyle = .pin
        XCTAssertEqual(SquareStyle.pin, style.squareStyle)
        XCTAssertEqual(24, style.spacing)
    }
}
