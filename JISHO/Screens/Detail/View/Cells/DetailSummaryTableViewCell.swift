//
//  DetailSummaryTableViewCell.swift
//  JISHO
//
//  Created by Alex on 16/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

class DetailSummaryTableViewCell: UITableViewCell {

    @IBOutlet private weak var kanjiLabel: UILabel! {
        didSet {
            kanjiLabel.textColor = UIColor(named: "SearchResultKanjiColor")
            kanjiLabel.layer.shadowColor = UIColor(named: "SearchResultModifier")?.cgColor
            kanjiLabel.layer.shadowRadius = 0
            kanjiLabel.layer.shadowOffset = CGSize(width: 3, height: 2)
            kanjiLabel.layer.shadowOpacity = 1
        }
    }
    
    @IBOutlet private weak var kanaLabel: InsetLabel! {
        didSet {
            kanaLabel.textColor = UIColor(named: "SearchResultKana")
            kanaLabel.contentInsets = UIEdgeInsets(top: 4, left: 4, bottom: 3, right: 4)
            kanaLabel.backgroundColor = UIColor(named: "SearchResultModifier")
            kanaLabel.layer.cornerRadius = 8
            kanaLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet private weak var romajiLabel: UILabel!
    
    func setUp(displayItem: DetailSummaryDisplayItem) {
        kanjiLabel.text = displayItem.kanji
        kanaLabel.text = displayItem.kana
        romajiLabel.text = displayItem.romaji
        
        adjustContentInsets()
    }
    
    private func adjustContentInsets() {
        kanaLabel.contentInsets = kanaLabel.text?.isEmpty == true ? .zero : UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

    }
}
