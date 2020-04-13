//
//  FaveButton.swift
//  JISHO
//
//  Created by Alex on 13/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

class FaveButton: UIButton {
    
    private var buttonState: FavouriteButtonState = .unfavourited {
        didSet {
            restyle()
        }
    }
    
    func setState(_ newState: FavouriteButtonState) {
        buttonState = newState
    }
    
    func flipState() -> FavouriteButtonState {
        buttonState = buttonState.oppositeState
        return buttonState
    }
    
    private func restyle() {
        setImage(buttonState.image, for: .normal)
        imageView?.tintColor = buttonState.color
    }
}

enum FavouriteButtonState {
    case unfavourited
    case favourited
    
    var image: UIImage? {
        switch self {
        case .unfavourited:
            return UIImage(systemName: "heart")
        case .favourited:
            return UIImage(systemName: "heart.fill")
        }
    }
    
    var color: UIColor {
        switch self {
        case .unfavourited: return UIColor(named: "DetailUnfavourited")!
        case .favourited: return UIColor(named: "DetailFavourited")!
        }
    }
    
    var oppositeState: FavouriteButtonState {
        switch self {
        case .unfavourited: return .favourited
        case .favourited: return .unfavourited
        }
    }
}
