//
//  MockRealmInterface.swift
//  JISHOTests
//
//  Created by Alex on 13/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

@testable import Ji_kun

class MockRealmInteractor: RealmInterface {
    var askedToSave = false
    var askedToDelete = false
    var wasAskedForStoredObjects = false
    
    func save(_ viewModel: DetailViewModel) {
        askedToSave = true
    }
    
    func save(_ displayItem: EntryDisplayItem) {
        askedToSave = true
    }
    
    func delete(_ viewModel: DetailViewModel) {
        askedToDelete = true
    }
    
    func delete(_ displayItem: EntryDisplayItem) {
        askedToDelete = true
    }
    
    func storedObjects() -> [SearchResultEntryModel] {
        wasAskedForStoredObjects = true
        return []
    }
}
