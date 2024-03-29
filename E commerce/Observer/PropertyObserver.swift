//
//  PropertyObserver.swift
//  Ecommerce
//
//  Created by Alok Ranjan on 04/02/24.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init( value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind( listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
