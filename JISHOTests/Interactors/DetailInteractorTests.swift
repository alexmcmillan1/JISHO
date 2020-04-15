//
//  DetailInteractorTests.swift
//  JISHOTests
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import Ji_kun

class DetailInteractorTests: XCTestCase {
    
    var sut: DetailInteractor!
    var mockPresenter: MockDetailPresenter!
    var mockRealmInterface: MockRealmInteractor!
    
    private func stubEntryDisplayItem() -> EntryDisplayItem {
        return EntryDisplayItem(favouriteButtonState: .unfavourited, mainForm: Form(word: "", reading: ""), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: [], kanji: [])
    }
    
    private func stubDetailViewModel() -> DetailViewModel {
        return DetailViewModel(favouriteButtonState: .unfavourited, displayItems: [])
    }
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockDetailPresenter()
        mockRealmInterface = MockRealmInteractor()
        sut = DetailInteractor(presenter: mockPresenter, realmInteractor: mockRealmInterface, data: stubEntryDisplayItem())
    }
    
    func test_detailInteractor_whenFavouriteIndicated_callsSaveOnRealmInterface() {
        sut.favouriteEntry(stubDetailViewModel())
        XCTAssertTrue(mockRealmInterface.askedToSave)
    }
    
    func test_detailInteractor_whenUnfavouriteIndicated_callsSaveOnRealmInterface() {
         sut.unfavouriteEntry(stubDetailViewModel())
         XCTAssertTrue(mockRealmInterface.askedToDelete)
    }
}

class MockDetailPresenter: DetailPresenting {
    var askedToMakeViewModel = false
    
    func makeViewModel(from searchDisplayItem: EntryDisplayItem, wikiExtract: String?, kanji: [KanjiAPIResponse]) -> DetailViewModel {
        askedToMakeViewModel = true
        return DetailViewModel(favouriteButtonState: .unfavourited, displayItems: [])
    }
}
