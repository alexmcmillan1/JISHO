//
//  FavouritesListPresenterTests.swift
//  JISHOTests
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import Ji_kun

class FavouritesListPresenterTests: XCTestCase {
    
    let sut = FavouritesListPresenter()
    let entryDisplayItem = EntryDisplayItem(isFavourite: true,
                                            mainForm: Form(word: "main", reading: "reading"),
                                            otherForms: [],
                                            definitions: [Definition(description: "d1desc", partsOfSpeech: "d1pos"),
                                                          Definition(description: "d2desc", partsOfSpeech: "d2pos")],
                                            definitionsNotSurfaced: 1,
                                            links: [ExternalLink(description: "l1desc", addressString: "l1add"),
                                                    ExternalLink(description: "l2desc", addressString: "l2add")],
                                            kanji: ["k1", "k2"])
    
    func test_whenPassedStoredObject_createsExpectedDisplayItem() {
        let items = sut.makeDisplayItems(from: [stubSearchResultEntryModel()])
        XCTAssertEqual(items.first!.mainForm.word, "main")
        XCTAssertEqual(items.first!.definitions.first!.description, "d1desc")
        XCTAssertEqual(items.first!.links[1].description, "l2desc")
        XCTAssertEqual(items.first!.kanji.first!, "k1")
    }
    
    private func stubSearchResultEntryModel() -> SearchResultEntryModel {
        return SearchResultEntryModel.fromEntryDisplayItem(item: self.entryDisplayItem)
    }
}
