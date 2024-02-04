//
//  ProductViewModel.swift
//  E commerce
//
//  Created by Alok Ranjan on 03/02/24.
//

import Foundation

class ProductViewModel {
    var products: Observable<[Record]> = Observable(value:[])
    var isAnimated: Observable<Bool> = Observable(value: false)
    
    func productWebService(with query: String, sortBy: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.isAnimated.value = true
            GetAllProduct.productService(with: query, sortBy: sortBy, completion: { [weak self] data in
                self?.isAnimated.value = false
                if let data {
                    self?.products.value = data
                }
            })
        }
    }
    
    func sortBYTapped(data: SortBYData) {
        switch data {
        case .Relevance:
            productWebService(with: "", sortBy: "Relevancia|0")
        case .NewestFirst:
            productWebService(with: "", sortBy: "newArrival|1")
        case .LowToHigh:
            productWebService(with: "", sortBy: "sortPrice|0")
        case .HighToLow:
            productWebService(with: "", sortBy: "sortPrice|1")
        case .rating:
            productWebService(with: "", sortBy: "rating|1")
        }
    }
}
