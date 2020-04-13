//
//  SearchResultTableViewCell.swift
//  JISHO
//
//  Created by Alex on 04/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 8
            containerView.backgroundColor = UIColor(named: "SearchResultContainerView")
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor(named: "SearchResultOutline")?.cgColor
        }
    }
    
    @IBOutlet private weak var readingLabel: InsetLabel! {
        didSet {
            readingLabel.textColor = UIColor(named: "SearchResultKana")
            readingLabel.contentInsets = UIEdgeInsets(top: 4, left: 4, bottom: 3, right: 4)
            readingLabel.backgroundColor = UIColor(named: "SearchResultModifier")
            readingLabel.layer.cornerRadius = 8
            readingLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var romajiLabel: InsetLabel! {
        didSet {
            romajiLabel.textColor = UIColor(named: "SearchResultKana")
        }
    }
    
    @IBOutlet private weak var wordLabel: UILabel! {
        didSet {
            wordLabel.textColor = UIColor(named: "SearchResultKanjiColor")
            wordLabel.layer.shadowColor = UIColor(named: "SearchResultModifier")?.cgColor
            wordLabel.layer.shadowRadius = 0
            wordLabel.layer.shadowOffset = CGSize(width: 3, height: 2)
            wordLabel.layer.shadowOpacity = 1
        }
    }
    
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
        romajiLabel.contentInsets = romajiLabel.text?.isEmpty == true ? .zero : UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    private func addMoreDefinitionsLabel(numItems: Int) {
        let label = UILabel()
        label.text = "and \(numItems) more"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        definitionsStackView.addArrangedSubview(label)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for subview in definitionsStackView.arrangedSubviews {
            definitionsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
