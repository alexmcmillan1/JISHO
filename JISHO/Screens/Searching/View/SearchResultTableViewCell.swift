//
//  SearchResultTableViewCell.swift
//  JISHO
//
//  Created by Alex on 04/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

protocol SearchResultTableViewCellFavouriteActionDelegate {
    func favourite(atRow index: Int)
    func unfavourite(atRow index: Int)
}

class SearchResultTableViewCell: UITableViewCell {
    
    var index: Int!
    var delegate: SearchResultTableViewCellFavouriteActionDelegate?
    
    @IBOutlet weak var shadowEmittingView: UIView! {
        didSet {
            shadowEmittingView.layer.shadowRadius = 8
            shadowEmittingView.layer.shadowOffset = CGSize(width: 2, height: 2)
            shadowEmittingView.layer.shadowColor = UIColor.black.cgColor
            shadowEmittingView.layer.shadowOpacity = 0.25
        }
    }
    
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet private weak var readingLabel: SearchKanaLabelView!
    
    @IBOutlet private weak var romajiLabel: RomajiLabelView! {
        didSet {
            romajiLabel.textColor = .text
        }
    }
    
    @IBOutlet private weak var wordLabel: SearchKanjiLabelView!
    
    @IBOutlet private weak var definitionsStackView: UIStackView!
    @IBOutlet private weak var favouriteButton: FaveButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    func setUp(displayItem: EntryDisplayItem) {
        favouriteButton.setState(displayItem.favouriteButtonState)
        setText(from: displayItem)
        let toShow = displayItem.definitions.count - displayItem.definitionsNotSurfaced
        
        for i in 0 ..< toShow {
            let definitionView = DefinitionView(definition: displayItem.definitions[i])
            definitionsStackView.addArrangedSubview(definitionView)
        }
        
        if displayItem.definitionsNotSurfaced > 0 {
            addMoreDefinitionsLabel(numItems: displayItem.definitionsNotSurfaced)
        }
        
        definitionsStackView.sizeToFit()
    }
    
    private func setText(from displayItem: EntryDisplayItem) {
        readingLabel.text = displayItem.mainForm.reading
        romajiLabel.text = displayItem.mainForm.reading.romaji()
        wordLabel.text = displayItem.mainForm.word
        
        adjustContentInsets()
    }
    
    private func adjustContentInsets() {
        readingLabel.contentInsets = readingLabel.text?.isEmpty == true ? .zero : UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    private func addMoreDefinitionsLabel(numItems: Int) {
        let label = MoreDefinitionsLabelView()
        label.setText(forNumberOfItems: numItems)
        definitionsStackView.addArrangedSubview(label)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for subview in definitionsStackView.arrangedSubviews {
            definitionsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    @IBAction func tappedFavourite(_ sender: Any) {
        if favouriteButton.flipState() == .favourited {
            delegate?.favourite(atRow: index)
        } else {
            delegate?.unfavourite(atRow: index)
        }
    }
}
