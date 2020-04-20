//
//  DefinitionView.swift
//  JISHO
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DefinitionView: UIView {
    
    private let partOfSpeechLabel = InsetLabel()
    private let descriptionLabel = UILabel()
    private var labelsGapConstraint: NSLayoutConstraint?
    
    convenience init(definition: Definition) {
        self.init(frame: .zero)
        setUp(definition: definition)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layOut()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layOut()
    }
    
    func setUp(definition: Definition) {
        partOfSpeechLabel.text = definition.partsOfSpeech
        descriptionLabel.text = definition.description
        
        if definition.partsOfSpeech.isEmpty {
            partOfSpeechLabel.contentInsets = .zero
            partOfSpeechLabel.isHidden = true
            labelsGapConstraint?.constant = 0
        }
    }
    
    private func layOut() {
        stylePartOfSpeechLabel()
        styleDescriptionLabel()
        addSubview(partOfSpeechLabel)
        addSubview(descriptionLabel)
        activateConstraints()
    }
    
    private func stylePartOfSpeechLabel() {
        partOfSpeechLabel.minimumScaleFactor = 0.5
        partOfSpeechLabel.adjustsFontSizeToFitWidth = true
        partOfSpeechLabel.layer.cornerRadius = 4
        partOfSpeechLabel.layer.masksToBounds = true
        partOfSpeechLabel.textColor = UIColor(named: "PartOfSpeechText")
        partOfSpeechLabel.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        partOfSpeechLabel.backgroundColor = UIColor(named: "PartOfSpeechBackground")
        partOfSpeechLabel.contentInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        partOfSpeechLabel.setContentHuggingPriority(.required, for: .vertical)
        partOfSpeechLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func styleDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .light)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func activateConstraints() {
        labelsGapConstraint = descriptionLabel.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 8)

        NSLayoutConstraint.activate([partOfSpeechLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     partOfSpeechLabel.topAnchor.constraint(equalTo: topAnchor),
        partOfSpeechLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)])
        
        NSLayoutConstraint.activate([descriptionLabel.leadingAnchor.constraint(equalTo: partOfSpeechLabel.leadingAnchor),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     labelsGapConstraint!,
                                     descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
