//
//  KanjiSummaryTableViewCell.swift
//  JISHO
//
//  Created by Alex on 01/03/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class KanjiSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var charLabel: SearchKanjiLabelView!
    @IBOutlet private weak var meaningsLabel: KanjiMeaningsLabelView!
 
    func setUp(_ displayItem: KanjiSummaryDisplayItem) {
        charLabel.text = displayItem.character
        meaningsLabel.text = displayItem.meanings
    }
}
