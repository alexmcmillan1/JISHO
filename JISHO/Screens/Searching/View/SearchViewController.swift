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
    var data: [EntryDisplayItem] { get set }
    func showErrorState(_ show: Bool)
}

class SearchViewController: UIViewController, SearchViewInput {
    
    var data: [EntryDisplayItem] = [] {
        didSet {
            tableView.contentOffset = CGPoint(x: 0, y: -64)
            tableView.reloadData()
            showEmptyState(data.isEmpty)
            showLoadingState(false)
        }
    }
    
    @IBOutlet private weak var promptGifViewA: UIImageView!
    @IBOutlet private weak var promptGifViewB: UIImageView!
    @IBOutlet private weak var promptGifViewC: UIImageView!
    
    @IBOutlet private weak var safeAreaTintView: UIView! {
        didSet {
            safeAreaTintView.backgroundColor = UIColor(named: "ViewBackground")
        }
    }
    
    private var activeSearchTerm: String?
    
    @IBOutlet private weak var activityIndicator: NVActivityIndicatorView!
    
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var emptyView: UIView!
    
    @IBOutlet private weak var searchPromptView: UIView! {
        didSet {
            searchPromptView.backgroundColor = UIColor(named: "ViewBackground")
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    
    private var wasScrollDirectionDown = true
    private var scrollContentOffsetAccumulator: CGFloat = 0
    private var previousScrollContentOffset: CGFloat = 0
    private var isSearchBarHidden = false
    
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
        view.backgroundColor = UIColor(named: "ViewBackground")
        navigationController?.navigationBar.isHidden = true
        textField.delegate = self
        setUpTableView()
        styleActivityIndicator()
        stylePromptViewComponents()
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "ViewBackground")
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    
    private func styleActivityIndicator() {
        activityIndicator.color = UIColor(named: "SearchResultOutline")!
        activityIndicator.type = .ballPulse
        activityIndicator.startAnimating()
    }
    
    private func stylePromptViewComponents() {
        do {
            try promptGifViewA.setGifImage(UIImage(gifName: "promptanimation.gif"))
            try promptGifViewB.setGifImage(UIImage(gifName: "promptanimation.gif"))
            try promptGifViewC.setGifImage(UIImage(gifName: "promptanimation.gif"))
        } catch {
            print("Couldn't load gif")
        }
        promptGifViewB.transform = CGAffineTransform(rotationAngle: 0.6)
        promptGifViewC.transform = CGAffineTransform(rotationAngle: -0.6)
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
    
    private func hideSearchBar() {
        UIViewPropertyAnimator(duration: 0.4, curve: .linear) {
            self.textField.transform = CGAffineTransform(translationX: 0, y: -100)
        }.startAnimation()
    }
    
    private func showSearchBar() {
        UIViewPropertyAnimator(duration: 0.4, curve: .easeOut) {
            self.textField.transform = .identity
        }.startAnimation()
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            searchPromptView.isHidden = true
            showEmptyState(false)
            showErrorState(false)
            showLoadingState(true)
            output.request(keyword: text)
            activeSearchTerm = textField.text
            textField.resignFirstResponder()
            tableView.setContentOffset(.zero, animated: false)
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
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == -64 && previousScrollContentOffset == 0) || scrollView.contentOffset.y < 0 {
            return
        }
        
        let isScrollDirectionDown = scrollView.contentOffset.y > previousScrollContentOffset
        
        if !wasScrollDirectionDown && isScrollDirectionDown {
            scrollContentOffsetAccumulator = 0
        } else if wasScrollDirectionDown && !isScrollDirectionDown {
            scrollContentOffsetAccumulator = 0
        }
        
        if isScrollDirectionDown {
            scrollContentOffsetAccumulator += scrollView.contentOffset.y - previousScrollContentOffset
            if scrollContentOffsetAccumulator > 44 && !isSearchBarHidden {
                isSearchBarHidden = true
                hideSearchBar()
            }
        } else {
            scrollContentOffsetAccumulator += previousScrollContentOffset - scrollView.contentOffset.y
            if scrollContentOffsetAccumulator > 44 && isSearchBarHidden {
                isSearchBarHidden = false
                showSearchBar()
            }
        }
        
        previousScrollContentOffset = scrollView.contentOffset.y
        wasScrollDirectionDown = isScrollDirectionDown
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
