//
//  FavouritesListViewController.swift
//  JISHO
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

protocol FavouritesListViewInput: class {
    func update(favourites: [EntryDisplayItem])
}

class FavouritesListViewController: UIViewController, FavouritesListViewInput {
    
    private var favourites: [EntryDisplayItem] = []
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyStateOverlay: UILabel!
    
    private var output: FavouritesListViewOutput!
    
    init(output: FavouritesListViewOutput) {
        super.init(nibName: "FavouritesListViewController", bundle: Bundle.main)
        self.output = output
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewIsReady()
    }
    
    func update(favourites: [EntryDisplayItem]) {
        self.favourites = favourites
        emptyStateOverlay.isHidden = !favourites.isEmpty
        tableView.reloadData()
    }

    private func setUpTableView() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FavouriteEntryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FavouriteEntryTableViewCell")
    }
}

extension FavouritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteEntryTableViewCell", for: indexPath) as! FavouriteEntryTableViewCell
        cell.setUp(favourites[indexPath.row])
        return cell
    }
}

extension FavouritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        output.delete(favourites[indexPath.row])
        favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        emptyStateOverlay.isHidden = !favourites.isEmpty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailInteractor = DetailInteractor(realmInteractor: RealmInteractor(), data: favourites[indexPath.row])
        let detailViewController = DetailViewController(output: detailInteractor, searchTerm: nil)
        detailInteractor.viewInput = detailViewController
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
