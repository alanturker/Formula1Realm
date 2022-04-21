//
//  StandingsTableViewCell.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    @IBOutlet private weak var driverNameLabel: UILabel!
    @IBOutlet private weak var driverPointsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(with model: DriverObject) {
        driverNameLabel.text = "Driver Name: \(model.name)"
        driverPointsLabel.text = "Driver Point: \(String(model.point))"
        if model.isFavorited {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteButton.tintColor = .systemYellow
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteButton.tintColor = .systemYellow
        }
        
    }

}
