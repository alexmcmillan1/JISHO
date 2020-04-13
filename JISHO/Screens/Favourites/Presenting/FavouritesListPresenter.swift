//
//  FavouritesListPresenter.swift
//  JISHO
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

protocol FavouritesListPresenting {
    func makeDisplayItems(from objects: [SearchResultEntryModel]) -> [EntryDisplayItem]
}

class FavouritesListPresenter: FavouritesListPresenting {
    
    func makeDisplayItems(from objects: [SearchResultEntryModel]) -> [EntryDisplayItem] {
        return objects.map { makeDisplayItem(from: $0) }
    }
    
    private func makeDisplayItem(from object: SearchResultEntryModel) -> EntryDisplayItem {
        return EntryDisplayItem(isFavourite: true,
                                mainForm: Form(word: object.mainFormWord, reading: object.mainFormReading),
                                otherForms: [],
                                definitions: definitions(from: object),
                                definitionsNotSurfaced: definitions(from: object).count - 1,
                                links: links(from: object),
                                kanji: kanji(from: object))
    }
    
    private func definitions(from object: SearchResultEntryModel) -> [Definition] {
        guard object.definitionDescriptions.count == object.definitionPartsOfSpeeches.count else { return [] }
        
        var definitions = [Definition]()
        
        for i in 0 ..< object.definitionDescriptions.count {
            definitions.append(Definition(description: object.definitionDescriptions[i], partsOfSpeech: object.definitionPartsOfSpeeches[i]))
        }
        
        return definitions
    }
    
    private func links(from object: SearchResultEntryModel) -> [ExternalLink] {
        guard object.linkDescriptions.count == object.linkAddressStrings.count else { return [] }
        
        var links = [ExternalLink]()
        
        for i in 0 ..< object.linkDescriptions.count {
            links.append(ExternalLink(description: object.linkDescriptions[i], addressString: object.linkAddressStrings[i]))
        }
        
        return links
    }
    
    private func kanji(from object: SearchResultEntryModel) -> [String] {
        return Array(object.kanji)
    }
}
