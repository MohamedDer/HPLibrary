//
//  CartService.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class CartService {
    
    let baseURLString = "http://henri-potier.xebia.fr/books/"
    let discountsEndPoint = "commercialOffers"
    
    var discounts: [Discount]?

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
    
    func getURLParams() -> String {
        if self.sharedCart.books.count == 0 {
            return "{}"
        } else {
            var paramSlug = "{"
            self.sharedCart.books.forEach { (book) in
                if let bookIsbn = book.isbn {
                    paramSlug += "\(bookIsbn),"
                }
            }
            paramSlug.removeLast()
            paramSlug += "}/"
            return paramSlug
        }
    }
    
    
    func getDiscounts(completion: @escaping () -> ()) {
        let urlString = baseURLString+getURLParams()+discountsEndPoint
        let safeURL = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        AF.request(safeURL! , method: .get).validate().responseJSON { (response) in
        switch response.result {
            case .success:
                let jsonObject = (response.value as? [String:Any])?["offers"]
                if let discounts = Mapper<Discount>().mapArray(JSONObject: jsonObject) {
                    self.discounts = discounts
                    self.getBestDiscountValue()
                }
            completion()
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }
    
    func getDiscountValue (of discount: Discount) -> Float {
        let totalPrice = AppServices.cartService.sharedCart.books.reduce(0) { (book, next) -> Int in
            return book + next.price!
        }
        var discountPrice: Float = 0

        switch discount.type! {
            case .percentage:
                discountPrice = Float(totalPrice * discount.value! / 100)
                break;
            case .minus:
                discountPrice = Float(totalPrice - discount.value!)
                break;
            case .slice:
                if ( totalPrice >= discount.sliceValue! ) {
                    discountPrice = Float(totalPrice - discount.value!)
                }
                break;
        }
        print("\(totalPrice)  discount val \(discountPrice)  with \(discount.type!)")

        return discountPrice
    }
    
    func getBestDiscountValue() -> Float {
        var bestDiscountValue: Float = 0
        self.discounts?.forEach({ (discount) in
            print(self.getDiscountValue(of: discount))
            if ( self.getDiscountValue(of: discount) >= bestDiscountValue) {
                bestDiscountValue = self.getDiscountValue(of: discount)
            }
        })
        print("best dis \(bestDiscountValue)")
        return bestDiscountValue
    }
    
}
