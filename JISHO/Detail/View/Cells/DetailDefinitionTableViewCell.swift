//
//  DetailDefinitionTableViewCell.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailDefinitionTableViewCell: UITableViewCell {

    @IBOutlet private weak var definitionView: DefinitionView!
    
    func setUp(definition: Definition) {
        definitionView.setUp(definition: definition)
    }
}
