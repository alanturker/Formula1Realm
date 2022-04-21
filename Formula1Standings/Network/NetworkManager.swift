//
//  NetworkManager.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import Moya

typealias driverCompletion = ([Driver]) -> Void
typealias detailCompletion = (Detail) -> Void

protocol Networkable {
    func fetchDriver(completionHandler: @escaping driverCompletion)
    func fetchDetail(with id: Int, completionHandler: @escaping detailCompletion)
}

final class NetworkManager: Networkable {
    
    var provider = MoyaProvider<driverAPI>(plugins: [NetworkLoggerPlugin()])
    
    func fetchDriver(completionHandler: @escaping driverCompletion) {
        provider.request(.driver) { driverResponse in
            switch driverResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(Standings.self, from: response.data)
                    completionHandler(results.drivers)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
    func fetchDetail(with id: Int, completionHandler: @escaping detailCompletion) {
        provider.request(.detail(id: id)) { detailResponse in
            switch detailResponse {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(Detail.self, from: response.data)
                    completionHandler(results)
                } catch let responseError {
                    print("responseError: \(responseError)")
                }
            case .failure(let serverError):
                print("serverError: \(serverError)")
            }
        }
    }
    
}
