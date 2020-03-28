//
//  CartService.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation


class CartService {
    
    fileprivate var _sharedCart : Cart?
    public var sharedCart: Cart {
        get {
            if let shared = self._sharedCart {
                 return shared
            } else {
                let shared = Cart()
                self._sharedCart = shared
                return  shared
            }
        }
        set {
           _sharedCart = newValue
        }
    }
    
}
