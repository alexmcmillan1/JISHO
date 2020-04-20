//
//  SearchFieldTableHeaderView.swift
//  JISHO
//
//  Created by Alex on 16/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class SearchFieldTableHeaderView: UIView, UITextFieldDelegate {
    
    let textField = UITextField()
    weak var delegate: UITextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateInit()
    }
    
    private func privateInit() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        addSubview(textField)
        NSLayoutConstraint
            .activate([textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                       textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                       textField.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                       textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)])
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(named: "SearchFieldBorder")?.cgColor 
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.placeholder = "Search"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let delegate = self.delegate else { return false }
        return delegate.textFieldShouldReturn?(textField) ?? false
    }
}
