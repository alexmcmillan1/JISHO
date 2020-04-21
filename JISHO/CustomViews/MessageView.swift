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
        backgroundColor = UIColor(named: "ViewBackground")
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     label.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
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
        font = .regular(size: 16)
        textColor = UIColor.label.withAlphaComponent(0.5)
        textAlignment = .center
    }
}
