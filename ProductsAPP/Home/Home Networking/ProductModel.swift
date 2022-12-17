//
//  ProductModel.swift
//  ProductsAPP
//
//  Created by MohamedNajeh on 16/12/2022.
//

import Foundation
// MARK: - ProductElement
struct Product: Codable {
    let id: Int?
    let productDescription: String?
    let image: Image?
    let price: Int?
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int?
    let url: String?
}

class StructWrapper<T>: NSObject {

    let value: T

    init(_ _struct: T) {
        self.value = _struct
    }
}

class YourStructHolder: NSObject {
    let thing: [Product]
    init(thing: [Product]) {
        self.thing = thing
    }
}
