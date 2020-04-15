//
//  SearchInteractorTests.swift
//  JISHOTests
//
//  Created by Alex on 13/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import JISHO_Go_

class SearchInteractorTests: XCTestCase {
    
    var mockPresenter: MockSearchPresenter!
    var mockRealmInteractor: MockRealmInteractor!
    var sut: SearchInteractor!
    
    override func setUp() {
        super.setUp()
        mockRealmInteractor = MockRealmInteractor()
        mockPresenter = MockSearchPresenter()
        sut = SearchInteractor(presenter: mockPresenter, realmInteractor: mockRealmInteractor)
    }
    
    func test_searchInteractor_whenViewWantsToFavouriteADisplayItem_callsRealmInterface() {
        sut.favourite(displayItem: stubEntryDisplayItem())
        XCTAssertTrue(mockRealmInteractor.askedToSave)
    }
    
    func test_searchInteractor_whenViewWantsToUnfavouriteADisplayItem_callsRealmInterface() {
        sut.unfavourite(displayItem: stubEntryDisplayItem())
        XCTAssertTrue(mockRealmInteractor.askedToDelete)
    }
    
    private func stubEntryDisplayItem() -> EntryDisplayItem {
        return EntryDisplayItem(favouriteButtonState: .unfavourited, mainForm: Form(word: "", reading: ""), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: [], kanji: [])
    }
}

class MockSearchPresenter: SearchPresenting {
    var wasAskedToMakeDisplayItems = false
    var wasAskedToDeduplicate = false
    
    func makeDisplayItems(from responseItems: [Datum], favouritesIds: [String]) -> [EntryDisplayItem] {
        wasAskedToMakeDisplayItems = true
        return []
    }
    
    func deduplicate(displayItems: [EntryDisplayItem]) -> [EntryDisplayItem] {
        wasAskedToDeduplicate = true
        return []
    }
}
