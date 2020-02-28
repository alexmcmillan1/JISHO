//
//  DetailViewModel.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

enum DetailDisplayItem {
    case summary(DetailSummaryDisplayItem)
    case definition(DetailDefinitionDisplayItem)
    case link(DetailLinkDisplayItem)
    case wikiExtract(DetailWikiExtractDisplayItem)
    case kanji(DetailKanjiDisplayItem)
}

struct DetailSummaryDisplayItem {
    let kanji: String
    let kana: String
    let romaji: String
}

struct DetailDefinitionDisplayItem {
    let definition: Definition
}

struct DetailLinkDisplayItem {
    let title: String
    let link: URL
}

struct DetailWikiExtractDisplayItem {
    let extract: String
}

enum DetailKanjiDisplayItem {
    case intro
    case character(DetailKanjiCharacterDisplayItem)
}

struct DetailKanjiCharacterDisplayItem {
    let character: String
    let meaning: String
}
