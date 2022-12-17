//
//  HomeViewModel.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func getProducts()
    func setError(_ message: ErrorMessages)
    var products: Observable<[Product]?> { get  set }
    var errorMessage: Observable<String?> { get set }
    var errorType: Observable<ErrorMessages?> { get set }
    var isLoading: Observable<Bool> { get set }
}

class HomeViewModel : HomeViewModelProtocol {
    
    
    var products: Observable<[Product]?>            = Observable(nil)
    
    var errorMessage: Observable<String?>           = Observable(nil)
    
    var errorType: Observable<ErrorMessages?>       = Observable(nil)
    
    var isLoading: Observable<Bool>                 = Observable(false)
    
    var api:HomeAPIProtocol?
    
    init(){
        self.api = HomeAPI()
    }
    
    func getProducts() {
        self.isLoading.value = true
        self.api?.getProducts(completion: { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let products):
                self?.products.value = products
                self?.saveData(products: products ?? [])
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: ErrorMessages) {
        self.errorType.value = message
        self.errorMessage.value = message.rawValue
    }
    
    func saveData(products:[Product]){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: "products")
        } catch {
            // Fallback
            self.setError(.errorSavingDataLocally)
        }
    }
    
    func getData(){
        guard let data = UserDefaults.standard.data(forKey: "products") else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            self.products.value = products
        } catch {
            // Fallback
            self.setError(.errorRetivingFromLocal)
        }
    }
}
