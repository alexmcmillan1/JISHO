//
//  WikiExtractTableViewCell.swift
//  JISHO
//
//  Created by Alex on 22/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailWikiExtractTableViewCell: UITableViewCell {

    @IBOutlet private weak var extractLabel: WikiExtractLabelView!
    
    func setUp(displayItem: DetailWikiExtractDisplayItem) {
        extractLabel.text = displayItem.extract
    }
}
