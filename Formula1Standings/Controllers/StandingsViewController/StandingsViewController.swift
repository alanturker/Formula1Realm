//
//  ViewController.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import UIKit
import RealmSwift

class StandingsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let networkManager = NetworkManager()
    
    private var driversArray: Results<DriverObject>?
    private var networkDriverArray: [Driver]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "GetDrivers",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTappedGetDriver))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDrivers()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
//MARK: - NavigationBarItem Method
extension StandingsViewController {
    @objc func didTappedGetDriver() {
        getDrivers()
    }
}
//MARK: - TableView Delegate & DataSource Methods
extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driversArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "driversCell", for: indexPath) as? StandingsTableViewCell else { return UITableViewCell() }
        if let driver = driversArray?[indexPath.row] {
            cell.favoriteButton?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFavoriteButton(sender:))))
            cell.setupUI(with: driver)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedDriver = driversArray?[indexPath.row] else { return }
        guard let detailVC = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        detailVC.driverID = selectedDriver.id
        detailVC.selectedDriverName = selectedDriver.name
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - Favorite Method
extension StandingsViewController {
    @objc func didTapFavoriteButton(sender: UITapGestureRecognizer) {
        let location = sender.location(in: tableView)
        let index = tableView?.indexPathForRow(at: location)
        guard let indexSafe = index else { return }
        let driver = driversArray?[indexSafe.row]
        RealmManager().saveFavorites(on: driver)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//MARK: - Network Methods
extension StandingsViewController {
    private func getDrivers() {
        networkManager.fetchDriver { [weak self] driverResults in
            guard self == self else  { return }
            self?.networkDriverArray = driverResults
            self?.networkDriverArray?.sort(by: {$0.point ?? 0 > $1.point ?? 0})
            self?.networkDriverArray?.forEach({ driver in
                RealmManager().save(on: driver)
            })
            self?.driversArray = try! Realm().objects(DriverObject.self)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func loadDrivers() {
        driversArray = try! Realm().objects(DriverObject.self)
        tableView.reloadData()
    }
}

