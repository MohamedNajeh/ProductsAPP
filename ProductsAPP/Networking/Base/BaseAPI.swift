//
//  BaseAPI.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation

class BaseAPI<T: TargetType> {
    
    
    func fetchData<B:Codable>(target: T,responseClass: B.Type ,completion: @escaping (Result<B,ErrorMessages>)->Void ){
        guard let url = URL(string: target.baseURL + target.path) else{
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.noInternet))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                //                print("response \(response)")
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let resultData = try decoder.decode(B.self, from: data)
                completion(.success(resultData))
                //                print(resultData)
                
            }catch{
                print(error.localizedDescription)
                completion(.failure(.invalidDataAfterDecoding))
                
            }
        }
        task.resume()
    }
}

