//
//  FavouriteEntry.swift
//  JISHO
//
//  Created by Alex on 29/03/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import RealmSwift

class FavouriteEntry: Object {
    dynamic var id = ""
    dynamic var mainWord = ""
    dynamic var mainReading = ""
    dynamic var otherForms = [(String, String)]()
    dynamic var definitions = [(String, String)]()
    dynamic var links = [(String, String)]()
    dynamic var kanji = [String]()
    
    convenience init(fromDisplayItem displayItem: EntryDisplayItem) {
        self.init()
        self.id = displayItem.mainForm.word + displayItem.mainForm.reading
        self.mainWord = displayItem.mainForm.word
        self.mainReading = displayItem.mainForm.reading
        self.otherForms = displayItem.otherForms.map { ($0.word, $0.reading) }
        self.definitions = displayItem.definitions.map { ($0.description, $0.partsOfSpeech) }
        self.links = displayItem.links.map { ($0.description, $0.addressString) }
        self.kanji = displayItem.kanji
    }
}
