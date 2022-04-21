//
//  RealmManager.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm = try! Realm()
    
    public func save(on driverObject: Driver?) {
        if let driverObject = driverObject {
            let favoritedDriverRealmObject = DriverObject()
            favoritedDriverRealmObject.id = driverObject.id ?? 0
            favoritedDriverRealmObject.name = driverObject.name ?? ""
            favoritedDriverRealmObject.point = driverObject.point ?? 0
            favoritedDriverRealmObject.isFavorited = driverObject.isFavorited
            realm.beginWrite()
            realm.add(favoritedDriverRealmObject)
            try! realm.commitWrite()
            
        }
    }
    
    public func deleteAll() {
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }
    
    public func saveFavorites(on driverObject: DriverObject?) {
        if let driverObject = driverObject {
            do {
                try realm.write({
                    driverObject.isFavorited.toggle()
                })
            } catch {
                print(error)
            }
        }
    }
    
    public func fetch() -> [Driver]? {
        var favoritedDrivers = [Driver]()
        let favoritedDriversInRealm = realm.objects(DriverObject.self)
        favoritedDriversInRealm.forEach { realmDriverObject in
            let realmDriverObject = Driver(id: realmDriverObject.id,
                                           name: realmDriverObject.name,
                                           point: realmDriverObject.point,
                                           isFavorited: realmDriverObject.isFavorited)
            favoritedDrivers.append(realmDriverObject)
        }
        return favoritedDrivers.filter { driver in
            driver.isFavorited
        }
    }
    
    public func delete(driverObject: Driver?) {
        if let driverObject = driverObject {
            let favoritedDriversInRealm = realm.objects(DriverObject.self)
            favoritedDriversInRealm.forEach { realmDriverObject in
                if realmDriverObject.id == driverObject.id {
                    do {
                        try realm.write({
                            realmDriverObject.isFavorited.toggle()
                        })
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
