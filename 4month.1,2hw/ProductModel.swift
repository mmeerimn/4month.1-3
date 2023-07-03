//
//  ProductModel.swift
//  4month.1,2hw
//
//  Created by meerim on 28.06.2023.
//

import Foundation

// MARK: - ProductsModel
struct ProductsModel: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}
 
// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
}
