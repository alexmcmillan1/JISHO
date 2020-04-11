//
//  SearchResultEntryModel.swift
//  JISHO
//
//  Created by Alex on 10/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResultEntryModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var mainFormWord = ""
    @objc dynamic var mainFormReading = ""
    dynamic var linkDescriptions = List<String>()
    dynamic var linkAddressStrings = List<String>()
    dynamic var definitionDescriptions = List<String>()
    dynamic var definitionPartsOfSpeeches = List<String>()
    dynamic var kanji = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func fromEntryDisplayItem(item: EntryDisplayItem) -> SearchResultEntryModel {
        let object = SearchResultEntryModel()
        
        object.mainFormWord = item.mainForm.word
        object.mainFormReading = item.mainForm.reading
        
        for link in item.links {
            object.linkDescriptions.append(link.description)
            object.linkAddressStrings.append(link.addressString)
        }
        
        for definition in item.definitions {
            object.definitionDescriptions.append(definition.description)
            object.definitionPartsOfSpeeches.append(definition.partsOfSpeech)
        }
        
        for kanji in item.kanji {
            object.kanji.append(kanji)
        }
        
        return object
    }
    
    static func fromDetailViewModel(viewModel: DetailViewModel) -> SearchResultEntryModel {
        let object = SearchResultEntryModel()
                
        for displayItem in viewModel.displayItems {
            switch displayItem {
            case .summary(let summary):
                object.id = summary.kanji + summary.kana
                object.mainFormWord = summary.kanji
                object.mainFormReading = summary.kana
            case .link(let link):
                object.linkDescriptions.append(link.title)
                object.linkAddressStrings.append(link.link.absoluteString)
            case .definition(let definition):
                object.definitionDescriptions.append(definition.definition.description)
                object.definitionPartsOfSpeeches.append(definition.definition.partsOfSpeech)
            case .kanji(let kanji):
                if case DetailKanjiDisplayItem.character(let charDisplayItem) = kanji {
                    object.kanji.append(charDisplayItem.character)
                }
            default:
                break
            }
        }
        
        return object
    }
}
