//
//  StringTests.swift
//  JISHOTests
//
//  Created by Alex on 23/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import JISHO

class StringTests: XCTestCase {

    func test_isKanji_withKanji_returnsTrue() {
        XCTAssertTrue("一".isKanji())
    }
    
    func test_isKanji_withMultipleCharacters_returnsFalse() {
        XCTAssertFalse("一二".isKanji())
    }
    
    func test_isKanji_withKana_returnsFalse() {
        XCTAssertFalse("ン".isKanji())
    }
    
    func test_isKanji_withAlphanumeric_returnsFalse() {
        XCTAssertFalse("A".isKanji())
    }
    
    func test_kanji_withOnlyKanji_returnsAll() {
        XCTAssertEqual(["日", "本"], "日本".kanji())
    }
    
    func test_kanji_withKanjiAndKana_returnsOnlyKanji() {
        XCTAssertEqual(["日", "本"], "日本で".kanji())
    }

    func test_kanji_withNoKanji_returnsEmpty() {
        XCTAssertEqual([], "abc".kanji())
    }
    
    func test_romaji_withNoInput_returnsEmpty() {
        XCTAssertEqual("", "".romaji())
    }
    
    func test_romaji_withNormalKana_returnsExpected() {
        XCTAssertEqual("nihon", "にほん".romaji())
    }
    
    func test_romaji_withKatakana_returnsEmpty() {
        XCTAssertEqual("", "".romaji())
    }
    
    func test_romaji_withDoubleConsonants_returnsExpected() {
        XCTAssertEqual("nippon", "にっぽん".romaji())
    }
    
    func test_romaji_withLongVowels_returnsExpected() {
        XCTAssertEqual("dou", "どう".romaji())
    }
    
    func test_romaji_withModifiedIEndings_returnsExpected() {
        XCTAssertEqual("gyuuniku", "ぎゅうにく".romaji())
    }
    
    func test_romaji_withModifiedShaCha_returnsExpected() {
        XCTAssertEqual("shashin", "しゃしん".romaji())
        XCTAssertEqual("chahan", "ちゃはん".romaji())
    }
}
