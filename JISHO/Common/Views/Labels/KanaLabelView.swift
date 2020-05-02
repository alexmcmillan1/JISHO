//
//  KanaLabelView.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class KanaLabelView: InsetLabel {
    
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
        contentInsets = UIEdgeInsets(top: 4, left: 4, bottom: 3, right: 4)
        backgroundColor = .primaryAccent
        numberOfLines = 1
        setUpLayer()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

class SearchKanaLabelView: KanaLabelView {
    
    override func selfInit() {
        super.selfInit()
        numberOfLines = 1
    }
}

class DetailKanaLabelView: KanaLabelView {
    
    override func selfInit() {
        super.selfInit()
        numberOfLines = 0
    }
}
