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
    var viewModel: DetailViewModel? { get set }
}

class DetailViewController: UIViewController, DetailViewInput {
    
    var viewModel: DetailViewModel? = nil {
        didSet {
            tableView.reloadData()
            loadingView.isHidden = true
            favouriteState = viewModel?.favouriteButtonState ?? FavouriteButtonState.unfavourited
        }
    }
    
    private var favouriteState: FavouriteButtonState = .unfavourited {
        didSet {
            styleFavouriteButton(state: favouriteState)
        }
    }
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favouriteButton: UIButton!
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
        styleActivityIndicator()
        
        output.viewIsReady()
    }
    
    private func setUpTableView() {
        registerTableViewCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    private func styleBackButton() {
        backButton.layer.cornerRadius = 22
    }
    
    private func setBackButtonTitle() {
        let backSuffix = searchTerm != nil ? " to \"\(searchTerm!)\"" : ""
        backButton.setTitle("Back\(backSuffix)", for: .normal)
    }
    
    private func styleActivityIndicator() {
        activityIndicator.color = UIColor(named: "SearchResultOutline")!
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
    
    @IBAction private func tappedFavourite(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        favouriteState = favouriteState.oppositeState
        if favouriteState == .favourited {
            output.favouriteEntry(viewModel)
        } else {
            output.unfavouriteEntry(viewModel)
        }
    }
    
    private func styleFavouriteButton(state: FavouriteButtonState) {
        favouriteButton.setImage(favouriteState.image, for: .normal)
        favouriteButton.imageView?.tintColor = favouriteState.color
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.displayItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = viewModel?.displayItems else { fatalError() }
        switch items[indexPath.row] {
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
        guard let item = viewModel?.displayItems[indexPath.row] else { return }
        if case let DetailDisplayItem.link(displayItem) = item {
            tableView.deselectRow(at: indexPath, animated: true)
            let safari = SFSafariViewController(url: displayItem.link)
            safari.delegate = self
            navigationController?.pushViewController(safari, animated: true)
        } else if case let DetailDisplayItem.kanji(displayItem) = item {
            if case DetailKanjiDisplayItem.character(let c) = displayItem {
                let interactor = KanjiInteractor(character: c.character)
                let kanjiDetail = KanjiViewController(output: interactor)
                interactor.viewInput = kanjiDetail
                presentPanModal(kanjiDetail)
            }
        }
    }
}

extension DetailViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
}

enum FavouriteButtonState {
    case unfavourited
    case favourited
    
    var imageConfiguration: UIImage.SymbolConfiguration{
        UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
    }
    
    var image: UIImage {
        switch self {
        case .unfavourited:
            return UIImage(systemName: "heart", withConfiguration: imageConfiguration)!
        case .favourited:
            return UIImage(systemName: "heart.fill", withConfiguration: imageConfiguration)!
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
    
    static func fromFavouriteState(_ favourited: Bool) -> FavouriteButtonState {
        return favourited ? .favourited : .unfavourited
    }
}
