//
//  API.swift
//  Formula1Standings
//
//  Created by alanturker on 17.04.2022.
//

import Foundation
import Moya

enum driverAPI {
    case driver
    case detail(id: Int)
}

fileprivate let urlDriver: String = "https://my-json-server.typicode.com/oguzayan/kuka"

extension driverAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: urlDriver) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .driver:
            return "/drivers"
        case .detail(let id):
            return "/driverDetail/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .driver, .detail(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .driver:
            return .requestPlain
        case .detail(id: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
