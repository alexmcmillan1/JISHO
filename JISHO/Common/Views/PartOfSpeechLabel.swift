//
//  PartOfSpeechLabel.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class PartOfSpeechLabel: InsetLabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        minimumScaleFactor = 0.5
        adjustsFontSizeToFitWidth = true
        textColor = UIColor(named: "PartOfSpeechText")
        font = .extraBold(size: 12)
        backgroundColor = UIColor(named: "PartOfSpeechBackground")
        contentInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        setContentHuggingPriority(.required, for: .vertical)
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
}
