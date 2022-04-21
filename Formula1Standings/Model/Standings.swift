//
//  Standings.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import RealmSwift

struct Standings: Codable {
    let drivers: [Driver] 
    
    private enum CodingKeys: String, CodingKey {
        case drivers = "items"
    }
}

struct Driver: Codable {
    let id: Int?
    let name: String?
    let point: Int?
    var isFavorited: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id,name,point
    }
}

