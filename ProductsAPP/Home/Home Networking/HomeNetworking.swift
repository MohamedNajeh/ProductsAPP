//
//  HomeNetworking.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation

enum HomeNetworking {
    case getProducts
}

extension HomeNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getProducts:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/uUfC1B"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Bearer "]
        }
    }
}
