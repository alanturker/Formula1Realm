//
//  FavoriteDriversViewController.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import UIKit
import RealmSwift

class FavoriteDriversViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var favoriteDriversArray: [Driver]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritedDrivers()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
//MARK: - TableView Delegate & DataSource Methods
extension FavoriteDriversViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDriversArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteDriversTableViewCell else { return UITableViewCell() }
        if let driver = favoriteDriversArray?[indexPath.row] {
            cell.setupUI(with: driver)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RealmManager().delete(driverObject: favoriteDriversArray?[indexPath.row])
            fetchFavoritedDrivers()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }
    
}
//MARK: - Fetch Favorited Drivers Method
extension FavoriteDriversViewController {
    private func fetchFavoritedDrivers() {
        favoriteDriversArray = RealmManager().fetch()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
