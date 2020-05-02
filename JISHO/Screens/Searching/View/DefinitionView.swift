//
//  DefinitionView.swift
//  JISHO
//
//  Created by Alex on 05/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DefinitionView: UIView {
    
    private let partOfSpeechLabel = PartOfSpeechLabel()
    private let descriptionLabel = DefinitionDescriptionLabel()
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
        addSubview(partOfSpeechLabel)
        addSubview(descriptionLabel)
        activateConstraints()
    }

    private func activateConstraints() {
        partOfSpeechLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
