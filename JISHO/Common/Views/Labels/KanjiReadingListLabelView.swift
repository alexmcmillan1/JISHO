//
//  KanjiReadingListLabelView.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class KanjiReadingListLabelView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        font = .jpMedium(size: 16)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
    }
}
