//
//  FavoriteDriversTableViewCell.swift
//  Formula1Standings
//
//  Created by alanturker on 18.04.2022.
//

import UIKit

class FavoriteDriversTableViewCell: UITableViewCell {

    @IBOutlet private weak var driverNameLabel: UILabel!
    @IBOutlet private weak var driverPointsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(with model: Driver) {
        driverNameLabel.text = "Driver Name: \(model.name ?? "")"
        driverPointsLabel.text = "Driver Point: \(String(model.point ?? 0))"
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.tintColor = .systemYellow
        
        
    }
}
