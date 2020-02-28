//
//  Language.swift
//  JISHO
//
//  Created by Alex on 17/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

enum Language: String {
    case english = "EN"
    case japanese = "日本語"
    
    var searchPlaceholder: String {
        switch self {
        case .english: return "e.g. house, flower"
        case .japanese: return "e.g. 面白い, nihon"
        }
    }
    
    var buttonBackgroundColor: UIColor {
        switch self {
        case .english: return .link
        case .japanese: return .japanButtonBackground
        }
    }
    
    var buttonTitleColor: UIColor {
        switch self {
        case .english: return .white
        case .japanese: return .japanButtonTitle
        }
    }
}
