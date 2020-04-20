//
//  UIFont.swift
//  JISHO
//
//  Created by Alex on 20/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

extension UIFont {
    static let customFontName = "Manrope"
    
    static func extraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-ExtraLight", size: size)!
    }
    
    static func light(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-Light", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-Regular", size: size)!
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-Medium", size: size)!
    }
    
    static func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-SemiBold", size: size)!
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-Bold", size: size)!
    }
    
    static func extraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "\(UIFont.customFontName)-ExtraBold", size: size)!
    }
}
