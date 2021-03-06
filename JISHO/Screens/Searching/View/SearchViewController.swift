//
//  SearchViewController.swift
//  JISHO
//
//  Created by Alex on 02/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftyGif

protocol SearchViewInput: class {
    func reload(withData data: [EntryDisplayItem])
    func showErrorState(_ show: Bool)
}

class SearchViewController: UIViewController, SearchViewInput {
    
    private var data: [EntryDisplayItem] = []
    
    @IBOutlet private weak var safeAreaTintView: UIView! {
        didSet {
            safeAreaTintView.backgroundColor = .background
        }
    }
    
    private var activeSearchTerm: String?
        
    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var errorView: UIView!
    
    @IBOutlet private weak var emptyView: MessageView! {
        didSet {
            emptyView.setMessage("No results... :(")
        }
    }
    
    @IBOutlet private weak var promptView: MessageView! {
        didSet {
            promptView.setMessage("You can search for words and phrases in English or Japanese (kanji, kana, or romaji).")
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private var searchFieldContainerView: SearchFieldTableHeaderView?
    
    var output: SearchViewOutput!
    
    init(output: SearchViewOutput) {
        super.init(nibName: "SearchViewController", bundle: Bundle.main)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableHeaderView()

        view.backgroundColor = .background
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func reload(withData data: [EntryDisplayItem]) {
        self.data = data
        tableView.reloadData()
        showEmptyState(data.isEmpty)
        showLoadingState(false)
    }
    
    private func setUpTableHeaderView() {
        searchFieldContainerView = SearchFieldTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 72))
        searchFieldContainerView?.delegate = self
        tableView.tableHeaderView = searchFieldContainerView
        // let _ = searchFieldContainerView?.becomeFirstResponder()
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .background
    }
    
    private func showLoadingState(_ show: Bool) {
        loadingView.isHidden = !show
    }
    
    private func showEmptyState(_ show: Bool) {
        emptyView.isHidden = !show
    }
    
    func showErrorState(_ show: Bool) {
        showLoadingState(false)
        errorView.isHidden = !show
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            promptView.isHidden = true
            showEmptyState(false)
            showErrorState(false)
            showLoadingState(true)
            output.request(keyword: text)
            activeSearchTerm = textField.text
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        cell.setUp(displayItem: data[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailInteractor = DetailInteractor(realmInteractor: RealmInteractor(), data: data[indexPath.row])
        let detailViewController = DetailViewController(output: detailInteractor, searchTerm: activeSearchTerm)
        detailInteractor.viewInput = detailViewController
        detailViewController.delegate = self
        
        let _ = (tableView.tableHeaderView as? SearchFieldTableHeaderView)?.resignFirstResponder()
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let _ = (tableView.tableHeaderView as? SearchFieldTableHeaderView)?.resignFirstResponder()
    }
}

extension SearchViewController: SearchResultTableViewCellFavouriteActionDelegate {
    func favourite(atRow index: Int) {
        output.favourite(displayItem: data[index])
        data[index].favouriteButtonState = data[index].favouriteButtonState.oppositeState
    }
    
    func unfavourite(atRow index: Int) {
        output.unfavourite(displayItem: data[index])
        data[index].favouriteButtonState = data[index].favouriteButtonState.oppositeState
    }
}

extension SearchViewController: DetailViewDelegate {
    func favourited(id: String) {
        let index = data.firstIndex(where: { ($0.mainForm.word + $0.mainForm.reading) == id })
        guard let intIndex = index?.magnitude else { return }
        data[Int(intIndex)].favouriteButtonState = .favourited
    }
    
    func unfavourited(id: String) {
        let index = data.firstIndex(where: { ($0.mainForm.word + $0.mainForm.reading) == id })
        guard let intIndex = index?.magnitude else { return }
        data[Int(intIndex)].favouriteButtonState = .unfavourited
    }
}
