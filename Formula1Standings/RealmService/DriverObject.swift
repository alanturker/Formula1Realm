//
//  DriverObject.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import RealmSwift

class DriverObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var point: Int = 0
    @objc dynamic var isFavorited: Bool = false
}



