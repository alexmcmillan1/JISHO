//
//  EntryDisplayItem.swift
//  JISHO
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

struct EntryDisplayItem {
    let isFavourite: Bool
    let mainForm: Form
    let otherForms: [Form]
    let definitions: [Definition]
    let definitionsNotSurfaced: Int
    let links: [ExternalLink]
    let kanji: [String]
}

struct Form: Equatable {
    let word: String
    let reading: String
}

struct Definition {
    let description: String
    let partsOfSpeech: String
}

struct ExternalLink {
    let description: String
    let addressString: String
}