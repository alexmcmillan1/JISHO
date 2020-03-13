//
//  String.swift
//  JISHO
//
//  Created by Alex on 12/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    static let alphanumeric = "1234567890qwertyuiopasdfghjklzxcvbnm"
    
    func onlyConsistsOf(characters: String) -> Bool {
        for char in self {
            if !characters.contains(char) {
                return false
            }
        }
        return true
    }
    
    func isKanji() -> Bool {
        guard count == 1, let unicodeValue = unicodeScalars.first?.value else { return false }
        return unicodeValue >= 19968 && unicodeValue <= 40895
    }
    
    func kanji() -> [String] {
        return self.filter { String($0).isKanji() }.map { String($0) }
    }
    
    func romaji() -> String {
        let chars: [String] = self.compactMap {
            Kana(rawValue: String($0))
        }
        .map { $0.romaji }
        .reduce("") { $0 + $1 }
        .enumerated()
        .map { String($1) }
        
        var result = ""
        
        // Double consonants
        
        for i in 0 ..< chars.count {
            if chars[i] == Kana.doubleNextConsonant.rawValue {
                result.append(chars[i+1])
            } else {
                result.append(chars[i])
            }
        }
        
        var finalResult = ""
        
        let intermediateResult = result.enumerated().map { String ($1) }
        
        var i = intermediateResult.count-1
        
        while(i >= 0) {
            if let kana = Kana(rawValue: intermediateResult[i]), kana.isSmallModifier {
                finalResult.append(String(kana.smallModifierRomaji.reversed()))
                i -= 2
            } else {
                finalResult.append(intermediateResult[i])
                i -= 1
            }
        }
        
        return String(finalResult.reversed()).shChProcessed()
    }
    
    func shChProcessed() -> String {
        return self
            .replacingOccurrences(of: "shya", with: "sha")
            .replacingOccurrences(of: "shyu", with: "shu")
            .replacingOccurrences(of: "shyo", with: "sho")
            .replacingOccurrences(of: "chya", with: "cha")
            .replacingOccurrences(of: "chyu", with: "chu")
            .replacingOccurrences(of: "chyo", with: "cho")
            .replacingOccurrences(of: "jya", with: "ja")
            .replacingOccurrences(of: "jyu", with: "ju")
            .replacingOccurrences(of: "jyo", with: "jo")
    }
}
