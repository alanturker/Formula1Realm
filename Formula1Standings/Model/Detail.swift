//
//  Detail.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation

struct Detail: Codable {
    let id: Int?
    let team: String?
    let age: Int?
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case id,team,age,image
    }
}
