//
//  KanjiAspectTableViewCell.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class KanjiAspectTableViewCell: UITableViewCell {

    @IBOutlet private weak var readingTypeLabel: KanjiReadingTypeLabelView!
    @IBOutlet private weak var valuesListLabel: KanjiReadingListLabelView!
    
    func setUp(type: ReadingType, list: String) {
        readingTypeLabel.text = type.rawValue
        valuesListLabel.text = list
        readingTypeLabel.style(forType: type)
    }
}
