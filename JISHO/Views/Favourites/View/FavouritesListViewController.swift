//
//  FavouritesListViewController.swift
//  JISHO
//
//  Created by Alex on 11/04/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import UIKit

protocol FavouritesListViewInput: class {
    var favourites: [EntryDisplayItem] { get set }
}

class FavouritesListViewController: UIViewController, FavouritesListViewInput {
    
    var favourites: [EntryDisplayItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
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
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewIsReady()
    }

    private func setUpTableView() {
        tableView.rowHeight = 80
        tableView.dataSource = self
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
