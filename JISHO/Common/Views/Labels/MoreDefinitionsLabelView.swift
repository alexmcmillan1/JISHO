//
//  MoreDefinitionsLabel.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class MoreDefinitionsLabelView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        font = .semiBold(size: 12)
    }
    
    func setText(forNumberOfItems n: Int) {
        text = n == 0 ? nil : "and \(n) more"
    }
}
