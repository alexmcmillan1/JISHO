//
//  DefinitionDescriptionLabel.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class DefinitionDescriptionLabelView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        numberOfLines = 0
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        font = .light(size: 15)
    }
}
