//
//  KanjiReadingTypeLabelView.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class KanjiReadingTypeLabelView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        font = .bold(size: 13)
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    func style(forType type: ReadingType) {
        backgroundColor = type.color
    }
}
