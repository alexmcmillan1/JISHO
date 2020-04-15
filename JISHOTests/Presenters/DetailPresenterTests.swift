//
//  DetailPresenterTests.swift
//  JISHOTests
//
//  Created by Alex on 23/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import JISHO_Go_

class DetailPresenterTests: XCTestCase {
    
    let sut = DetailPresenter()

    func test_makeDisplayItems_withKanji_createsExpectedItem() {
        let kanjiResponse = KanjiAPIResponse(kanji: "四", meanings: ["meaning", "other meaning"])
        let viewModel = sut.makeViewModel(from: createDisplayItem(), wikiExtract: nil, kanji: [kanjiResponse])
        for item in viewModel.displayItems {
            if case let DetailDisplayItem.kanji(DetailKanjiDisplayItem.character(displayItem)) = item {
                XCTAssertEqual("四", displayItem.character)
                XCTAssertEqual("meaning; other meaning", displayItem.meaning)
            }
        }
    }
    
    func test_makeDisplayItems_withLinks_trimsAnyOldIds() {
        let data = createDisplayItem(links: [ExternalLink(description: "Link", addressString: "http://en.wikipedia.org/wiki/Chinese_language?oldid=494871625")])
        
        let viewModel = sut.makeViewModel(from: data, wikiExtract: nil, kanji: [])
        
        for item in viewModel.displayItems {
            if case let DetailDisplayItem.link(displayItem) = item {
                XCTAssertEqual("http://en.wikipedia.org/wiki/Chinese_language", displayItem.link.absoluteString)
            }
        }
    }
    
    private func createDisplayItem(links: [ExternalLink] = []) -> EntryDisplayItem {
        return EntryDisplayItem(favouriteButtonState: .unfavourited, mainForm: Form(word: "", reading: ""), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: links, kanji: [])
    }
}
