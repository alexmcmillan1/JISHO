//
//  KanjiAPIResponse.swift
//  JISHO
//
//  Created by Alex on 23/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

struct KanjiAPIResponse: Decodable {
    let kanji: String
    let meanings: [String]
}
