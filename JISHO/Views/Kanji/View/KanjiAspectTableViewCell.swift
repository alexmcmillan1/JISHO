//
//  KanjiAspectTableViewCell.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class KanjiAspectTableViewCell: UITableViewCell {

    @IBOutlet private weak var readingTypeLabel: UILabel! {
        didSet {
            readingTypeLabel.layer.cornerRadius = 4
            readingTypeLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var valuesListLabel: UILabel!
    
    func setUp(type: ReadingType, list: String) {
        readingTypeLabel.text = type.rawValue
        valuesListLabel.text = list
        readingTypeLabel.backgroundColor = type.color
    }
}
