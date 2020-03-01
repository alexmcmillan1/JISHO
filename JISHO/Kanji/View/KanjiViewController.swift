//
//  KanjiViewController.swift
//  JISHO
//
//  Created by Alex on 29/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit
import PanModal

protocol KanjiViewInput: class {
    var data: [KanjiDetail] { get set }
}

class KanjiViewController: UIViewController, KanjiViewInput, UITableViewDataSource, PanModalPresentable {
    
    // MARK: PanModalPresentable
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(240)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(240)
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    // MARK: Ends
    
    @IBOutlet private weak var dragIndicator: UIView! {
        didSet {
            dragIndicator.layer.cornerRadius = 2
            dragIndicator.layer.masksToBounds = true
        }
    }
    
    var output: KanjiViewOutput!
    
    var data: [KanjiDetail] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(UINib(nibName: "KanjiSummaryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "KanjiSummaryTableViewCell")
            tableView.register(UINib(nibName: "KanjiAspectTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "KanjiAspectTableViewCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 64
        }
    }
    
    init(output: KanjiViewOutput) {
        super.init(nibName: "KanjiViewController", bundle: Bundle.main)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
        case .summary(let summary):
            let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiSummaryTableViewCell", for: indexPath) as! KanjiSummaryTableViewCell
            cell.setUp(summary)
            return cell
        case .reading(let reading):
            let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiAspectTableViewCell", for: indexPath) as! KanjiAspectTableViewCell
            cell.setUp(type: reading.type, list: reading.values)
            return cell
        }
    }
}
