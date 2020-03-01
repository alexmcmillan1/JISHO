//
//  KanjiPresenter.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation

protocol KanjiPresenting: class {
    func makeDisplayItems(from responseItem: KanjiResponseItem) -> [KanjiDetail]
}

class KanjiPresenter: KanjiPresenting {
    
    func makeDisplayItems(from responseItem: KanjiResponseItem) -> [KanjiDetail] {
        
        var result = [KanjiDetail]()
        
        result.append(KanjiDetail.summary(KanjiSummaryDisplayItem(character: responseItem.kanji, gradeDescription: gradeDescription(from: responseItem.grade), strokeCountDescription: "\(responseItem.stroke_count) strokes", meanings: responseItem.meanings.joined(separator: "; "), jlptDescription: jlptDescription(from: responseItem.jlpt))))
        
        for reading in readings(from: responseItem) {
            result.append(KanjiDetail.reading(reading))
        }
        
        return result
    }
    
    private func jlptDescription(from jlpt: Int?) -> String {
        guard let jlpt = jlpt else { return "" }
        return "JLPT N\(jlpt)"
    }
    
    private func gradeDescription(from grade: Int?) -> String {
        guard let grade = grade else { return "" }
        return "Grade \(grade)"
    }
    
    private func readings(from responseItem: KanjiResponseItem) -> [KanjiReadingDisplayItem] {
        let kunReadings = KanjiReadingDisplayItem(type: .kun, values: responseItem.kun_readings.joined(separator: ", "))
        let onReadings = KanjiReadingDisplayItem(type: .on, values: responseItem.on_readings.joined(separator: ", "))
        let nameReadings = KanjiReadingDisplayItem(type: .name, values: responseItem.name_readings.joined(separator: ", "))
        
        return [kunReadings, onReadings, nameReadings]
    }
}
