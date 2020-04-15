//
//  FavouriteEntryTableViewCell.swift
//  JISHO
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class FavouriteEntryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var firstDefinitionLabel: UILabel!
    @IBOutlet private weak var moreDefinitionsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleContainerView()
        styleWordLabel()
    }
    
    func setUp(_ displayItem: EntryDisplayItem) {
        wordLabel.text = displayItem.mainForm.word
        firstDefinitionLabel.text = displayItem.definitions.first?.description ?? ""
        moreDefinitionsLabel.text = displayItem.definitionsNotSurfaced == 0 ? "" : "and \(displayItem.definitionsNotSurfaced) more"
    }
    
    private func styleContainerView() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(named: "SearchResultOutline")?.cgColor
    }
    
    private func styleWordLabel() {
        wordLabel.layer.shadowColor = UIColor(named: "FavouriteShadow")?.cgColor
        wordLabel.layer.shadowRadius = 0
        wordLabel.layer.shadowOffset = CGSize(width: 3, height: 2)
        wordLabel.layer.shadowOpacity = 1
    }
}
