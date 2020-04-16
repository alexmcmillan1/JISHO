//
//  DetailLinkTableViewCell.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailLinkTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var linkButton: UIButton! {
        didSet {
            linkButton.backgroundColor = UIColor.systemBlue
            linkButton.setTitleColor(UIColor.white, for: .normal)
            linkButton.layer.cornerRadius = 8
        }
    }
    
    func setUp(displayItem: DetailLinkDisplayItem) {
        linkButton.setTitle(displayItem.title, for: .normal)
    }
}
