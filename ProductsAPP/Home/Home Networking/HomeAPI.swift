//
//  HomeAPI.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation
protocol HomeAPIProtocol {
    func getProducts(completion: @escaping (Result<[Product]?, ErrorMessages>) -> Void)
}

class HomeAPI: BaseAPI<HomeNetworking>, HomeAPIProtocol {
    func getProducts(completion: @escaping (Result<[Product]?, ErrorMessages>) -> Void) {
        self.fetchData(target: .getProducts, responseClass: [Product]?.self) { result in
            completion(result)
        }
    }
}
