//
//  AppServices.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation

class AppServices {

    static fileprivate var _booksService: BooksService?
    static var booksService: BooksService {
        get {
            if let booksService: BooksService = AppServices._booksService {
                return booksService
            } else {
                let booksService = BooksService()
                AppServices._booksService = booksService
                return booksService
            }
        }
        set {
            AppServices._booksService = newValue
        }
    }
    
    
    static fileprivate var _discountService: DiscountService?
    static var discountService: DiscountService {
        get {
            if let discountService: DiscountService = AppServices._discountService {
                return discountService
            } else {
                let discountService = DiscountService()
                AppServices._discountService = discountService
                return discountService
            }
        }
        set {
            AppServices._discountService = newValue
        }
    }
    
    
 
    static fileprivate var _cartService: CartService?
    static var cartService: CartService {
        get {
            if let cartService: CartService = AppServices._cartService {
                return cartService
            } else {
                let cartService = CartService()
                AppServices._cartService = cartService
                return cartService
            }
        }
        set {
            AppServices._cartService = newValue
        }
    }
}
