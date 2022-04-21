//
//  UIImageView + KF.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    func fetchImage(from urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}
