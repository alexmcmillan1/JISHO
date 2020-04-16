//
//  RealmInteractor.swift
//  JISHO
//
//  Created by Alex on 10/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmInterface {
    func save(_ viewModel: DetailViewModel)
    func save(_ displayItem: EntryDisplayItem)
    func delete(_ viewModel: DetailViewModel)
    func delete(_ displayItem: EntryDisplayItem)
    func storedObjects() -> [SearchResultEntryModel]
}

class RealmInteractor: RealmInterface {
    let realm = try! Realm()
    
    func save(_ viewModel: DetailViewModel) {
        let object = SearchResultEntryModel.fromDetailViewModel(viewModel: viewModel)
        try! realm.write {
            realm.add(object)
        }
    }
    
    func save(_ displayItem: EntryDisplayItem) {
        let object = SearchResultEntryModel.fromEntryDisplayItem(item: displayItem)
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(_ viewModel: DetailViewModel) {
        let object = SearchResultEntryModel.fromDetailViewModel(viewModel: viewModel)
        let objectToDelete = realm.objects(SearchResultEntryModel.self).filter("id == \"\(object.id)\"")
        try! realm.write {
            realm.delete(objectToDelete)
        }
    }
    
    func delete(_ displayItem: EntryDisplayItem) {
        let object = SearchResultEntryModel.fromEntryDisplayItem(item: displayItem)
        let objectToDelete = realm.objects(SearchResultEntryModel.self).filter("id == \"\(object.id)\"")
        try! realm.write {
            realm.delete(objectToDelete)
        }
    }
    
    func storedObjects() -> [SearchResultEntryModel] {
        return Array(realm.objects(SearchResultEntryModel.self))
    }
}
