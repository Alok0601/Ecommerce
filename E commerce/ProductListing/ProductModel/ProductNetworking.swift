//
//  ProductNetworking.swift
//  E commerce
//
//  Created by Alok Ranjan on 03/02/24.
//

import Foundation

class GetAllProduct {
    
    static func productService(with query: String, sortBy: String, completion: @escaping ([Record]?) -> Void) {
        guard let url = generateURL(with: query, sortBy: sortBy) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Product.self, from: data)
                completion(decodedResponse.plpResults?.records)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private static func generateURL(with query: String, sortBy: String) -> URL? {
        let urlString = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v6/plp/sf?page-number=1&number-of-items-per-page=40&search-string=\(query)&sort-option=\(sortBy)"
        return URL(string: urlString)
    }
}
