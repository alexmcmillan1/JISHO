//
//  SearchPresenter.swift
//  JISHO
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

protocol SearchPresenting: class {
    func makeDisplayItems(from responseItems: [Datum], favouritesIds: [String]) -> [EntryDisplayItem]
    func deduplicate(displayItems: [EntryDisplayItem]) -> [EntryDisplayItem]
}

class SearchPresenter: SearchPresenting {
    func makeDisplayItems(from responseItems: [Datum], favouritesIds: [String]) -> [EntryDisplayItem] {
        return responseItems.compactMap { makeDisplayItem(from: $0, favouritesIds: favouritesIds) }
    }
    
    private func makeDisplayItem(from responseItem: Datum, favouritesIds: [String]) -> EntryDisplayItem? {
        guard let firstForm = responseItem.japanese.first,
            !responseItem.slug.onlyConsistsOf(characters: String.alphanumeric) else { return nil }

        let mainForm = self.mainForm(from: responseItem.slug, firstForm: firstForm)
        let otherForms = self.otherForms(from: responseItem.japanese)
        let definitions = self.definitions(from: responseItem.senses)
        let links = self.links(from: responseItem.senses)
        let notSurfaced = definitions.count - 2
        
        let matchingFavouriteId: String? = favouritesIds.first { id -> Bool in
            id == mainForm.word + mainForm.reading
        }
                
        return EntryDisplayItem(isFavourite: matchingFavouriteId != nil,
                                mainForm: mainForm,
                                otherForms: otherForms,
                                definitions: definitions,
                                definitionsNotSurfaced: notSurfaced > 0 ? notSurfaced : 0,
                                links: links,
                                kanji: mainForm.word.kanji())
    }
    
    private func mainForm(from slug: String, firstForm: Japanese) -> Form {
        let slugTrimmed = String(slug.prefix { $0 != "-" })
        let reading: String = firstForm.reading ?? ""
        return Form(word: slugTrimmed, reading: reading)
    }
    
    private func otherForms(from japanese: [Japanese]) -> [Form] {
        return Array(japanese.dropFirst()).map {
            Form(word: $0.word ?? "", reading: $0.reading ?? "")
        }
    }
    
    private func definitions(from senses: [Sense]) -> [Definition] {
        return senses.compactMap {
            return $0.parts_of_speech.joined(separator: ", ") == "Wikipedia definition"
                ? nil
                : Definition(description: $0.english_definitions.joined(separator: "; "),
                             partsOfSpeech: $0.parts_of_speech.joined(separator: ", "))
        }
    }
    
    private func links(from senses: [Sense]) -> [ExternalLink] {
        var result = [ExternalLink]()
        
        for sense in senses {
            for link in sense.links {
                result.append(ExternalLink(description: link.text, addressString: link.url))
            }
        }
        
        return result
    }
    
    func deduplicate(displayItems: [EntryDisplayItem]) -> [EntryDisplayItem] {
        var result = [EntryDisplayItem]()
        
        for item in displayItems {
            if !result.contains(where: { (existing) -> Bool in
                return item.mainForm == existing.mainForm
            }) {
                result.append(item)
            }
        }
        
        return result
    }
}
