//
//  KanjiDetailTableViewCell.swift
//  JISHO
//
//  Created by Alex on 23/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailKanjiCharacterTableViewCell: UITableViewCell {

    @IBOutlet private weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 8
            parentView.backgroundColor = UIColor(named: "SearchResultContainerView")
            parentView.layer.borderWidth = 1
            parentView.layer.borderColor = UIColor(named: "SearchResultOutline")?.cgColor
        }
    }
    
    @IBOutlet private weak var characterLabel: SearchKanjiLabelView!
    @IBOutlet private weak var meaningLabel: KanjiMeaningsLabelView!
    
    func setUp(displayItem: DetailKanjiCharacterDisplayItem) {
        characterLabel.text = displayItem.character
        meaningLabel.text = displayItem.meaning
        
        characterLabel.sizeToFit()
    }
}
