//
//  SearchTextField.swift
//  JISHO
//
//  Created by Alex on 02/05/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class SearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selfInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selfInit()
    }
    
    fileprivate func selfInit() {
        borderStyle = .none
        layer.borderColor = UIColor.backgroundContrast2?.cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        textAlignment = .center
        placeholder = "Search"
        font = .regular(size: 16)
    }
}
