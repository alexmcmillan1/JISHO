//
//  FavouritesListInteractorTests.swift
//  JISHOTests
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import Ji_kun

class FavouritesListInteractorTests: XCTestCase {
    
    var sut: FavouritesListInteractor!
    var mockPresenter: MockFavouritesListPresenter!
    var mockRealmInterface: MockRealmInterface!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockFavouritesListPresenter()
        mockRealmInterface = MockRealmInterface()
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
}

class MockFavouritesListPresenter: FavouritesListPresenting {
    var askedToMakeDisplayItems = false
    
    func makeDisplayItems(from objects: [SearchResultEntryModel]) -> [EntryDisplayItem] {
        askedToMakeDisplayItems = true
        return []
    }
}
