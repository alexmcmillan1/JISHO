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
    func delete(_ viewModel: DetailViewModel)
}

class RealmInteractor: RealmInterface {
    let realm = try! Realm()
    
    func save(_ viewModel: DetailViewModel) {
        let object = SearchResultEntryModel.fromDetailViewModel(viewModel: viewModel)
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
}
