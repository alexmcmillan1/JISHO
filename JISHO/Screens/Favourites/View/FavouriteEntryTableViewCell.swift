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
    @IBOutlet private weak var wordLabel: FavouritedKanjiLabelView!
    @IBOutlet private weak var firstDefinitionLabel: DefinitionDescriptionLabelView!
    @IBOutlet private weak var moreDefinitionsLabel: MoreDefinitionsLabelView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleContainerView()
    }
    
    func setUp(_ displayItem: EntryDisplayItem) {
        wordLabel.text = displayItem.mainForm.word
        firstDefinitionLabel.text = displayItem.definitions.first?.description ?? ""
        moreDefinitionsLabel.setText(forNumberOfItems: displayItem.definitionsNotSurfaced)
    }
    
    private func styleContainerView() {
        containerView.layer.cornerRadius = 8
    }
}
