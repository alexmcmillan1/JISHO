//
//  KanjiDisplayItem.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit.UIColor

enum KanjiDetail {
    case summary(KanjiSummaryDisplayItem)
    case reading(KanjiReadingDisplayItem)
}

struct KanjiSummaryDisplayItem {
    let character: String
    let gradeDescription: String
    let strokeCountDescription: String
    let meanings: String
    let jlptDescription: String
}

struct KanjiReadingDisplayItem {
    let type: ReadingType
    let values: String
}

enum ReadingType: String {
    case kun = "KUN"
    case on = "ON"
    case name = "NAME"
    
    var color: UIColor {
        switch self {
        case .kun: return UIColor.kunReading!
        case .on: return UIColor.onReading!
        case .name: return UIColor.nameReading!
        }
    }
}
