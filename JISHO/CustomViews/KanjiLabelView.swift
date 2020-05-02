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
        font = .jpMedium(size: 48.0)
        textColor = UIColor(named: "SearchResultKanjiColor")
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.shadowColor = UIColor(named: "SearchResultModifier")?.cgColor
        layer.shadowRadius = 0
        layer.shadowOffset = CGSize(width: 3, height: 2)
        layer.shadowOpacity = 1
    }
}

class LargeKanjiLabelView: KanjiLabelView {
    
    override func selfInit() {
        super.selfInit()
        font = font.withSize(72.0)
    }
}
