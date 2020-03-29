//
//  FavouritingInteractor.swift
//  JISHO
//
//  Created by Alex on 29/03/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavouritingInteractorInput: class {
    func storeSearchResultEntry(representing displayItem: EntryDisplayItem)
}

class FavouritingInteractor: FavouritingInteractorInput {
    func storeSearchResultEntry(representing displayItem: EntryDisplayItem) {
        
        let storableObject = FavouriteEntry(fromDisplayItem: displayItem)
        
        do {
            let realm = try Realm()
            realm.add(storableObject)
        } catch {
            fatalError("Realm error")
        }
    }
}
