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
        
        let kanjiDetail = sut.makeDisplayItems(from: responseItem)
        
        for detail in kanjiDetail {
            switch detail {
            case .summary(let summary):
                XCTAssertEqual("日", summary.character)
                XCTAssertEqual("Grade 5", summary.gradeDescription)
                XCTAssertEqual("5 strokes", summary.strokeCountDescription)
                XCTAssertEqual("sun; day", summary.meanings)
                XCTAssertEqual("JLPT N5", summary.jlptDescription)
            case .reading(let reading):
                switch reading.type {
                case .kun: XCTAssertEqual("ka, ki", reading.values)
                case .on: XCTAssertEqual("ku, ke", reading.values)
                case .name: XCTAssertEqual("ko, sa", reading.values)
                }
            }
        }
    }
}
