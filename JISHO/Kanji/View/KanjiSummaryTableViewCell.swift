//
//  KanjiSummaryTableViewCell.swift
//  JISHO
//
//  Created by Alex on 01/03/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class KanjiSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var charLabel: UILabel! {
        didSet {
            charLabel.layer.cornerRadius = 8
            charLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var meaningsLabel: UILabel!
 
    func setUp(_ displayItem: KanjiSummaryDisplayItem) {
        charLabel.text = displayItem.character
        meaningsLabel.text = displayItem.meanings
    }
}
