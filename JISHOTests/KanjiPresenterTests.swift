//
//  KanjiPresenterTests.swift
//  JISHOTests
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import JISHO

class KanjiPresenterTests: XCTestCase {

    let sut = KanjiPresenter()

    func test_makeDisplayItem_withNormalResponse_producesExpectedResult() {
        let responseItem = KanjiResponseItem(kanji: "日",
                                             grade: 5,
                                             stroke_count: 5,
                                             meanings: ["sun", "day"],
                                             kun_readings: ["ka", "ki"],
                                             on_readings: ["ku", "ke"],
                                             name_readings: ["ko", "sa"],
                                             jlpt: 5,
                                             unicode: "5",
                                             heisig_en: "sun")
        
        let displayItem = sut.makeDisplayItem(from: responseItem)
        
        XCTAssertEqual("日", displayItem.character)
        XCTAssertEqual("Grade 5", displayItem.gradeDescription)
        XCTAssertEqual("5 strokes", displayItem.strokeCountDescription)
        XCTAssertEqual("sun; day", displayItem.meanings)
        XCTAssertEqual(ReadingType.kun, displayItem.readings[0].type)
        XCTAssertEqual("ka, ki", displayItem.readings[0].values)
        XCTAssertEqual(ReadingType.on, displayItem.readings[1].type)
        XCTAssertEqual("ku, ke", displayItem.readings[1].values)
        XCTAssertEqual(ReadingType.name, displayItem.readings[2].type)
        XCTAssertEqual("ko, sa", displayItem.readings[2].values)
        XCTAssertEqual("JLPT N5", displayItem.jlptDescription)
        
    }
}
