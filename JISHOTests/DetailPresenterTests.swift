//
//  DetailPresenterTests.swift
//  JISHOTests
//
//  Created by Alex on 23/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import Ji_kun

class DetailPresenterTests: XCTestCase {
    
    let sut = DetailPresenter()

    func test_makeDisplayItems_withKanji_createsExpectedItem() {
        let kanjiResponse = KanjiAPIResponse(kanji: "四", meanings: ["meaning", "other meaning"])
        let displayItems = sut.makeDisplayItems(from: createDisplayItem(), wikiExtract: nil, kanji: [kanjiResponse])
        for vm in displayItems {
            if case let DetailDisplayItem.kanji(DetailKanjiDisplayItem.character(displayItem)) = vm {
                XCTAssertEqual("四", displayItem.character)
                XCTAssertEqual("meaning; other meaning", displayItem.meaning)
            }
        }
    }
    
    func test_makeDisplayItems_withLinks_trimsAnyOldIds() {
        let data = createDisplayItem(links: [ExternalLink(description: "Link", addressString: "http://en.wikipedia.org/wiki/Chinese_language?oldid=494871625")])
        
        let displayItems = sut.makeDisplayItems(from: data, wikiExtract: nil, kanji: [])
        
        for vm in displayItems {
            if case let DetailDisplayItem.link(displayItem) = vm {
                XCTAssertEqual("http://en.wikipedia.org/wiki/Chinese_language", displayItem.link.absoluteString)
            }
        }
    }
    
    private func createDisplayItem(links: [ExternalLink] = []) -> EntryDisplayItem {
        return EntryDisplayItem(mainForm: Form(word: "", reading: ""), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: links, kanji: [])
    }
}
