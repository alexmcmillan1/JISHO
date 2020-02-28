//
//  DetailSummaryTableViewCell.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailSummaryTableViewCell: UITableViewCell {

    @IBOutlet private weak var kanjiLabel: UILabel!
    @IBOutlet private weak var kanaLabel: UILabel!
    @IBOutlet private weak var romajiLabel: UILabel!
    
    func setUp(displayItem: DetailSummaryDisplayItem) {
        kanjiLabel.text = displayItem.kanji
        kanaLabel.text = displayItem.kana
        romajiLabel.text = displayItem.romaji
    }
    
}
