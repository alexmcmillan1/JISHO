//
//  PromptMessageView.swift
//  JISHO
//
//  Created by Alex on 20/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class MessageView: UIView {
    
    private let label = GenericViewMessageLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateInit()
    }
    
    private func privateInit() {
        backgroundColor = .background
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -44),
                                     label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
        
    }
    
    func setMessage(_ text: String) {
        label.text = text
    }
}

class GenericViewMessageLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customise()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customise()
    }
    
    private func customise() {
        text = "!not set"
        font = .regular(size: 13)
        numberOfLines = 0
        textColor = .systemGray2
        textAlignment = .center
    }
}
