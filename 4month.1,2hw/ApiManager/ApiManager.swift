//
//  ApiModel.swift
//  4month.1,2hw
//
//  Created by meerim on 28.06.2023.
//

import Foundation

class ApiManager{
    
    static let shared = ApiManager()
    
    func requestData(completition: @escaping (Result<ProductsModel,Error>) -> Void) {
        
        guard let url = URL(string: "https://dummyjson.com/products") else {return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {return}
            
            do {
                let value = try JSONDecoder().decode(ProductsModel.self, from: data)
                completition(.success(value))
            } catch {
                completition(.failure(error))
            }
        }
        task.resume()
    }
    
    func requestPostData(id: Int, title: String, price: Int, completition: @escaping (Result<Int,Error>) -> Void) {
        
        guard let url = URL(string: "https://dummyjson.com/products/add") else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let product = [Product(id: 0, title: "", description: "", price: 0, discountPercentage: 0, rating: 0, stock: 0, brand: "", category: "", thumbnail: "", images: .init())]
        
        request.httpBody = try? JSONEncoder().encode(product)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {return}
            
            do{
                completition(.success((response.statusCode)))
            } catch {
                completition(.failure(error))
            }
        }
        task.resume()
    }
    
}
