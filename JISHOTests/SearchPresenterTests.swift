//
//  JISHOTests.swift
//  JISHOTests
//
//  Created by Alex on 08/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import XCTest
@testable import Ji_kun

class SearchPresenterTests: XCTestCase {
    
    let sut = SearchPresenter()
    
    // Main entry uses slug as the word
    func test_makeDisplayItem_usesSlugWord_asMainWord() {
        let slug = Datum(slug: "日本", japanese: [Japanese(word: nil, reading: "にほん")], senses: [])
        let displayItem = sut.makeDisplayItem(from: slug)
        XCTAssertEqual("日本", displayItem?.mainForm.word)
    }
    
    // Main entry uses first Japanese kana (reading) as its reading
    func test_mainEntry_usesFirstReading_asReading() {
        let slug = Datum(slug: "日本", japanese: [Japanese(word: "日本", reading: "にほん")], senses: [])
        let displayItem = sut.makeDisplayItem(from: slug)
        XCTAssertEqual("にほん", displayItem?.mainForm.reading)
    }
    
    // Make sure any -(num) is stripped from the slug
    func test_ifHyphenNumberOnSlug_removesIt() {
        let slug1 = Datum(slug: "日本", japanese: [Japanese(word: nil, reading: "にほん")], senses: [])
        let slug2 = Datum(slug: "日本-1", japanese: [Japanese(word: nil, reading: "にほんにほん")], senses: [])
        
        let displayItems = [slug1, slug2].compactMap { (slug) -> EntryDisplayItem? in
            sut.makeDisplayItem(from: slug)
        }
        
        XCTAssertEqual("日本", displayItems[1].mainForm.word)
    }
    
    func test_ifSlugIsAlphanumeric_removesIt() {
        let slug1 = Datum(slug: "1234567890", japanese: [Japanese(word: nil, reading: "Reading")], senses: [])
        let slug2 = Datum(slug: "dcb5", japanese: [Japanese(word: nil, reading: "Reading")], senses: [])
        let slug3 = Datum(slug: "日本", japanese: [Japanese(word: nil, reading: "にっぽん")], senses: [])
        
        let displayItems = [slug1, slug2, slug3].compactMap { (slug) -> EntryDisplayItem? in
            sut.makeDisplayItem(from: slug)
        }
        
        XCTAssertEqual(1, displayItems.count)
        XCTAssertEqual("日本", displayItems.first?.mainForm.word)
    }
    
    func test_ifWikipediaDefinitionInPartsOfSpeech_omitsFromDisplayItem() {
        let slug = Datum(slug: "日本", japanese: [Japanese(word: nil, reading: "にっぽん")], senses: [Sense(english_definitions: ["Japan"], parts_of_speech: ["Wikipedia definition"], links: [])])
        
        let displayItem = sut.makeDisplayItem(from: slug)
        
        XCTAssertTrue(displayItem!.definitions.isEmpty)
    }
    
    func test_ifLinksPresentInPartsOfSpeech_addedToDisplayItem() {
        let slug = Datum(slug: "日本", japanese: [Japanese(word: nil, reading: "にっぽん")], senses: [Sense(english_definitions: ["Japan"], parts_of_speech: ["Wikipedia definition"], links: [Link(text: "English Wikipedia", url: "https://something")])])
        
        let displayItem = sut.makeDisplayItem(from: slug)
        
        XCTAssertEqual(1, displayItem?.links.count)
    }
    
    func test_ifOtherFormsPresent_addedToDisplayItem() {
        let slug = Datum(slug: "日本", japanese: [Japanese(word: "日本", reading: "にほん"), Japanese(word: "日本", reading: "にっぽん")], senses: [])
        
        let displayItem = sut.makeDisplayItem(from: slug)
        
        XCTAssertEqual(1, displayItem?.otherForms.count)
        XCTAssertEqual("にっぽん", displayItem?.otherForms.first!.reading)
    }
    
    func test_ifMoreThan2Definitions_numberIncludedAsNotSurfaced() {
        let slug = Datum(slug: "日本",
                         japanese: [Japanese(word: "日本", reading: "にほん"), Japanese(word: "日本", reading: "にっぽん")],
                         senses: [Sense(english_definitions: ["A"], parts_of_speech: ["Noun"], links: []),
                                  Sense(english_definitions: ["B"], parts_of_speech: ["Noun"], links: []),
                                  Sense(english_definitions: ["C"], parts_of_speech: ["Noun"], links: [])])
        
        let displayItem = sut.makeDisplayItem(from: slug)!
        
        XCTAssertEqual(1, displayItem.definitionsNotSurfaced)
    }
    
    func test_if2Definitions_notSurfacedIs0() {
        let slug = Datum(slug: "日本",
                         japanese: [Japanese(word: "日本", reading: "にほん"),
                                    Japanese(word: "日本", reading: "にっぽん")],
                         senses: [Sense(english_definitions: ["A"], parts_of_speech: ["Noun"], links: []),
                                  Sense(english_definitions: ["B"], parts_of_speech: ["Noun"], links: [])])
        
        let displayItem = sut.makeDisplayItem(from: slug)!
        
        XCTAssertEqual(0, displayItem.definitionsNotSurfaced)
    }
    
    func test_ifFewerThan2Definitions_notSurfacedIs0() {
        let slug = Datum(slug: "日本",
                         japanese: [Japanese(word: "日本", reading: "にほん"), Japanese(word: "日本", reading: "にっぽん")],
                         senses: [Sense(english_definitions: ["A"], parts_of_speech: ["Noun"], links: [])])
        
        let displayItem = sut.makeDisplayItem(from: slug)!
        
        XCTAssertEqual(0, displayItem.definitionsNotSurfaced)
    }
    
    func test_deduplicate_removesDuplicateDisplayItems() {
        let inputItems: [EntryDisplayItem] = [EntryDisplayItem(mainForm: Form(word: "日本", reading: "にほん"), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: [], kanji: []), EntryDisplayItem(mainForm: Form(word: "日本", reading: "にほん"), otherForms: [], definitions: [], definitionsNotSurfaced: 0, links: [], kanji: [])]
        
        let deduplicated = sut.deduplicate(displayItems: inputItems)
        
        XCTAssertEqual(1, deduplicated.count)
    }
}
