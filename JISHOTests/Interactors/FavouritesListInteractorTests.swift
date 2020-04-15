//
//  FavouritesListInteractorTests.swift
//  JISHOTests
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import JISHO_Go_

class FavouritesListInteractorTests: XCTestCase {
    
    var sut: FavouritesListInteractor!
    var mockPresenter: MockFavouritesListPresenter!
    var mockRealmInterface: MockRealmInteractor!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockFavouritesListPresenter()
        mockRealmInterface = MockRealmInteractor()
        sut = FavouritesListInteractor(realmInteractor: mockRealmInterface, presenter: mockPresenter)
    }
    
    func test_whenViewIsReady_interactorTalksToRealm() {
        sut.viewIsReady()
        XCTAssertTrue(mockRealmInterface.wasAskedForStoredObjects)
    }
    
    func test_whenViewIsReady_interactorRequestsDisplayItemsFromPresenter() {
        sut.viewIsReady()
        XCTAssertTrue(mockPresenter.askedToMakeDisplayItems)
    }
    
    func test_whenDeleteIndicated_callsSaveOnRealmInterface() {
        sut.delete(stubEntryDisplayItem())
        XCTAssertTrue(mockRealmInterface.askedToDelete)
    }
    
    private func stubEntryDisplayItem() -> EntryDisplayItem {
        return EntryDisplayItem(favouriteButtonState: .favourited, mainForm: Form(word: "", reading: ""), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: [], kanji: [])
    }
}

class MockFavouritesListPresenter: FavouritesListPresenting {
    var askedToMakeDisplayItems = false
    
    func makeDisplayItems(from objects: [SearchResultEntryModel]) -> [EntryDisplayItem] {
        askedToMakeDisplayItems = true
        return []
    }
}
