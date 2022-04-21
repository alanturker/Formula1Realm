//
//  DetailViewController.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var driverImage: UIImageView!
    @IBOutlet private weak var driverName: UILabel!
    @IBOutlet private weak var driverAge: UILabel!
    @IBOutlet private weak var driverTeam: UILabel!

    let networkManager = NetworkManager()
    private var selectedDriver: Detail?
    var driverID: Int = 0
    var selectedDriverName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSelectedDriver(with: driverID) {
            self.configureOutlets()
        }
    }
    
}
//MARK: - Fetch Favorited Movies
extension DetailViewController {
    private func fetchSelectedDriver(with id: Int, completion: @escaping () -> Void) {
        networkManager.fetchDetail(with: id) { [weak self] detailResponse in
            guard let strongSelf = self else { return }
            strongSelf.selectedDriver = detailResponse
            completion()
        }
    }
}
//MARK: - Configure Outlets Method
extension DetailViewController {
    private func configureOutlets() {
        driverName?.text = "Driver Name: \(selectedDriverName)"
        driverAge.text = "Driver Age: \(String(selectedDriver?.age ?? 0))"
        driverTeam.text = "Driver Team: \(selectedDriver?.team ?? "")"
        driverImage.fetchImage(from: selectedDriver?.image ?? "")
    }
}
