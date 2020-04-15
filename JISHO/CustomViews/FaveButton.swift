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
    
    private var feedbackGenerator: UINotificationFeedbackGenerator?
    
    private var buttonState: FavouriteButtonState = .unfavourited {
        didSet {
            restyle()
        }
    }
    
    func setState(_ newState: FavouriteButtonState) {
        buttonState = newState
    }
    
    func flipState() -> FavouriteButtonState {
        feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator?.prepare()
        buttonState = buttonState.oppositeState
        triggerHapticFeedback()
        animate()
        return buttonState
    }
    
    private func triggerHapticFeedback() {
        feedbackGenerator?.notificationOccurred(.success)
    }
    
    private func animate() {
        transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.35) {
            self.transform = .identity
        }.startAnimation()
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
