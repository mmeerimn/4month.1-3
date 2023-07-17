//
//  ApiModel.swift
//  4month.1,2hw
//
//  Created by meerim on 28.06.2023.
//

import Foundation

enum RequestType {
    case get
    case post(id: Int, name: String, price: Int, brand: String, category: String)
}

enum DataType {
    case model(ProductsModel)
    case statusCode(Int)
}

class ApiManager {
    
    static let shared = ApiManager()
    
    func universalRequest(type: RequestType, completition: @escaping (Result<DataType,Error>) -> Void) {
        switch type {
        case .get:
            guard let url = URL(string: "https://dummyjson.com/products") else {return}
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else {return}
                
                do {
                    let model = try JSONDecoder().decode(ProductsModel.self, from: data)
                    completition(.success(.model(model)))
                } catch {
                    completition(.failure(error))
                }
            }
            task.resume()
        
        case .post(let id, let name, let price, let brand, let category):
            guard let url = URL(string: "https://dummyjson.com/products/add") else {return}
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            let product = [Product(id: id, title: name, description: "", price: price, discountPercentage: 0, rating: 0, stock: 0, brand: brand, category: category, thumbnail: "", images: .init())]
            
            request.httpBody = try? JSONEncoder().encode(product)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {return}
                
                do{
                    completition(.success(.statusCode(response.statusCode)))
                } catch {
                    completition(.failure(error))
                }
            }
            task.resume()
        }
    }
}
