//
//  KanjiLabelView.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class KanjiLabelView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        font = .jpMedium(size: 17.0)
        textColor = .text
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.shadowColor = UIColor.primaryAccent?.cgColor
        layer.shadowRadius = 0
        layer.shadowOffset = CGSize(width: 3, height: 2)
        layer.shadowOpacity = 1
    }
}

class SearchKanjiLabelView: KanjiLabelView {
    
    override func selfInit() {
        super.selfInit()
        font = font.withSize(44.0)
        numberOfLines = 0
    }
}

class DetailKanjiLabelView: KanjiLabelView {
    
    override func selfInit() {
        super.selfInit()
        font = font.withSize(64.0)
        numberOfLines = 3
    }
}

class FavouritedKanjiLabelView: KanjiLabelView {
    
    override func selfInit() {
        super.selfInit()
        font = font.withSize(32.0)
        numberOfLines = 1
    }
}
