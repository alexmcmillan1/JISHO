//
//  KanjiResponseItem.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

struct KanjiResponseItem: Decodable {
    let kanji: String
    let grade: Int?
    let stroke_count: Int
    let meanings: [String]
    let kun_readings: [String]
    let on_readings: [String]
    let name_readings: [String]
    let jlpt: Int?
    let unicode: String
    let heisig_en: String?
}

//{
//  "kanji": "蜜",
//  "grade": 8,
//  "stroke_count": 14,
//  "meanings": [
//    "honey",
//    "nectar",
//    "molasses"
//  ],
//  "kun_readings": [],
//  "on_readings": [
//    "ミツ",
//    "ビツ"
//  ],
//  "name_readings": [],
//  "jlpt": null,
//  "unicode": "871c",
//  "heisig_en": "honey"
//}
