//
//  FavouritesListInteractor.swift
//  JISHO
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

protocol FavouritesListViewOutput {
    func viewIsReady()
}

class FavouritesListInteractor: FavouritesListViewOutput {
    
    weak var viewInput: FavouritesListViewInput?
    
    private let realmInteractor: RealmInterface
    private let presenter: FavouritesListPresenting
    
    init(realmInteractor: RealmInterface, presenter: FavouritesListPresenting) {
        self.realmInteractor = realmInteractor
        self.presenter = presenter
    }
    
    func viewIsReady() {
        let storedObjects: [SearchResultEntryModel] = realmInteractor.storedObjects()
        let displayItems: [EntryDisplayItem] = presenter.makeDisplayItems(from: storedObjects)
        viewInput?.favourites = displayItems
    }
}
