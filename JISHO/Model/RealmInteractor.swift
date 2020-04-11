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
    func save(_ viewModel: DetailViewModel) {
        let object = SearchResultEntryModel.fromDetailViewModel(viewModel: viewModel)
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(_ viewModel: DetailViewModel) {
        let object = SearchResultEntryModel.fromDetailViewModel(viewModel: viewModel)
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
}
