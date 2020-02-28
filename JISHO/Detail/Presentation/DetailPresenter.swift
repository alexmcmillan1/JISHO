//
//  DetailPresenter.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

protocol DetailPresenting: class {
    func makeDisplayItems(from searchDisplayItem: EntryDisplayItem, wikiExtract: String?, kanji: [KanjiAPIResponse]) -> [DetailDisplayItem]
}

class DetailPresenter: DetailPresenting {
    
    func makeDisplayItems(from searchDisplayItem: EntryDisplayItem, wikiExtract: String?, kanji: [KanjiAPIResponse]) -> [DetailDisplayItem] {
        var result: [DetailDisplayItem] = []
        
        let summaryItem = DetailDisplayItem.summary(DetailSummaryDisplayItem(kanji: searchDisplayItem.mainForm.word,
                                                                             kana: searchDisplayItem.mainForm.reading,
                                                                             romaji: searchDisplayItem.mainForm.reading.romaji()))
        
        result.append(summaryItem)
        
        for def in searchDisplayItem.definitions {
            result.append(DetailDisplayItem.definition(DetailDefinitionDisplayItem(definition: def)))
        }
        
        for character in kanji {
            result.append(DetailDisplayItem.kanji(DetailKanjiDisplayItem
                .character(DetailKanjiCharacterDisplayItem(character: character.kanji,
                                                           meaning: character.meanings.joined(separator: "; ")))))
        }
        
        if let extract = wikiExtract {
            result.append(DetailDisplayItem.wikiExtract(DetailWikiExtractDisplayItem(extract: extract)))
        }
        
        searchDisplayItem.links
            .compactMap { makeLinkItem(from: $0) }
            .forEach { result.append(DetailDisplayItem.link($0)) }
        
        return result
    }
    
    private func makeLinkItem(from link: ExternalLink) -> DetailLinkDisplayItem? {
        var trimmedWikiString = link.addressString
        
        if link.addressString.contains("wikipedia") {
            if let firstHalf = link.addressString.components(separatedBy: "?").first {
                trimmedWikiString = firstHalf
            }
        }
        
        if let pctString = trimmedWikiString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: pctString) {
            return DetailLinkDisplayItem(title: link.description, link: url)
        } else {
            return nil
        }
    }
}
