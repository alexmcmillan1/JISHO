//
//  DetailViewController.swift
//  JISHO
//
//  Created by Alex on 15/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit
import SafariServices
import NVActivityIndicatorView

protocol DetailViewInput: class {
    var data: [DetailDisplayItem] { get set }
}

class DetailViewController: UIViewController, DetailViewInput {
    
    var data: [DetailDisplayItem] = [] {
        didSet {
            tableView.reloadData()
            loadingView.isHidden = true
        }
    }
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: NVActivityIndicatorView!
    
    private var output: DetailViewOutput!
    private var searchTerm: String?
    
    init(output: DetailViewOutput, searchTerm: String?) {
        super.init(nibName: "DetailViewController", bundle: Bundle.main)
        self.output = output
        self.searchTerm = searchTerm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "ViewBackground")
        setUpTableView()
        styleBackButton()
        setBackButtonTitle()
        styleActivityIndicator()
        
        output.viewIsReady()
    }
    
    private func setUpTableView() {
        registerTableViewCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
    
    private func styleBackButton() {
        backButton.setTitleColor(.link, for: .normal)
        backButton.setTitleColor(.linkHighlighted, for: .highlighted)
        backButton.setImage(UIImage(named: "BackArrow")?.withTintColor(.link), for: .normal)
        backButton.setImage(UIImage(named: "BackArrow")?.withTintColor(.linkHighlighted), for: .highlighted)
    }
    
    private func setBackButtonTitle() {
        let backSuffix = searchTerm != nil ? " to \"\(searchTerm!)\"" : ""
        backButton.setTitle("Back\(backSuffix)", for: .normal)
    }
    
    private func styleActivityIndicator() {
        activityIndicator.color = .japanButtonBackground
        activityIndicator.type = .ballPulse
        activityIndicator.startAnimating()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "DetailSummaryTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "DetailSummaryTableViewCell")
        tableView.register(UINib(nibName: "DetailDefinitionTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "DetailDefinitionTableViewCell")
        tableView.register(UINib(nibName: "DetailLinkTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "DetailLinkTableViewCell")
        tableView.register(UINib(nibName: "DetailWikiExtractTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "DetailWikiExtractTableViewCell")
        tableView.register(UINib(nibName: "DetailKanjiCharacterTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "DetailKanjiCharacterTableViewCell")
        tableView.register(UINib(nibName: "KanjiSectionHeaderTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "KanjiSectionHeaderTableViewCell")
    }
    
    @IBAction private func tappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch data[indexPath.row] {
        case .summary(let displayItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailSummaryTableViewCell",
                                                     for: indexPath) as! DetailSummaryTableViewCell
            cell.setUp(displayItem: displayItem)
            return cell
        case .definition(let displayItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDefinitionTableViewCell",
                                                     for: indexPath) as! DetailDefinitionTableViewCell
            cell.setUp(definition: displayItem.definition)
            return cell
        case .link(let displayItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailLinkTableViewCell",
                                                     for: indexPath) as! DetailLinkTableViewCell
            cell.setUp(displayItem: displayItem)
            return cell
        case .wikiExtract(let displayItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWikiExtractTableViewCell",
                                                     for: indexPath) as! DetailWikiExtractTableViewCell
            cell.setUp(displayItem: displayItem)
            return cell
        case .kanji(.character(let displayItem)):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailKanjiCharacterTableViewCell",
                                                     for: indexPath) as! DetailKanjiCharacterTableViewCell
            cell.setUp(displayItem: displayItem)
            return cell
        case .kanji(.intro):
            let cell = tableView.dequeueReusableCell(withIdentifier: "KanjiSectionHeaderTableViewCell", for: indexPath) as! KanjiSectionHeaderTableViewCell
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let DetailDisplayItem.link(displayItem) = data[indexPath.row] {
            tableView.deselectRow(at: indexPath, animated: true)
            let safari = SFSafariViewController(url: displayItem.link)
            safari.delegate = self
            navigationController?.pushViewController(safari, animated: true)
        }
    }
}

extension DetailViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
}
