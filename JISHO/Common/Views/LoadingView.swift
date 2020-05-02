//
//  LoadingView.swift
//  JISHO
//
//  Created by Alex on 22/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
        
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
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        NSLayoutConstraint.activate([indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     indicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
}
