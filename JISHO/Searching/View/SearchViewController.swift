//
//  SearchViewController.swift
//  JISHO
//
//  Created by Alex on 02/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol SearchViewInput: class {
    var data: [EntryDisplayItem] { get set }
}

class SearchViewController: UIViewController, SearchViewInput {
    
    var data: [EntryDisplayItem] = [] {
        didSet {
            tableView.reloadData()
            emptyView.isHidden = !data.isEmpty
            loadingView.isHidden = true
        }
    }
    
    private var activeSearchTerm: String?
    private var inputLanguage: Language = .english {
        didSet {
            textField.placeholder = inputLanguage.searchPlaceholder
            languageInputButton.setTitle(inputLanguage.rawValue, for: .normal)
            languageInputButton.setTitleColor(inputLanguage.buttonTitleColor, for: .normal)
            languageInputButton.backgroundColor = inputLanguage.buttonBackgroundColor
        }
    }
    
    @IBOutlet private weak var languageInputButton: UIButton!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet private weak var emptyView: UIView!
    @IBOutlet private weak var searchPromptView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    
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
        inputLanguage = .english
        textField.delegate = self
        setUpTableView()
        styleLanguageButton()
        styleActivityIndicator()
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: "ViewBackground")
    }
    
    private func styleLanguageButton() {
        languageInputButton.layer.cornerRadius = 4
        languageInputButton.titleLabel?.adjustsFontSizeToFitWidth = true
        languageInputButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    private func styleActivityIndicator() {
        activityIndicator.color = .japanButtonBackground
        activityIndicator.type = .ballPulse
        activityIndicator.startAnimating()
    }
    
    @IBAction private func tappedLanguageButton(_ sender: Any) {
        inputLanguage = (inputLanguage == .english) ? .japanese : .english
    }
    
    private func showLoadingState() {
        loadingView.isHidden = false
        searchPromptView.isHidden = true
        emptyView.isHidden = true
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            showLoadingState()
            output.request(keyword: text, language: inputLanguage)
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
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailInteractor = DetailInteractor(data: data[indexPath.row])
        let detailViewController = DetailViewController(output: detailInteractor, searchTerm: activeSearchTerm)
        detailInteractor.viewInput = detailViewController
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
