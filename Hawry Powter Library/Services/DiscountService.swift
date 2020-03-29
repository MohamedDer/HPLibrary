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


class DiscountService {
    
    let baseURLString = "http://henri-potier.xebia.fr/books/"
    let discountsEndPoint = "commercialOffers"
    
    var discounts: [Discount]?

    var sharedCart = AppServices.cartService.sharedCart
    
    func getURLParams() -> String {
        if self.sharedCart.books.count == 0 {
            return ""
        } else {
            var paramSlug = ""
            self.sharedCart.books.forEach { (book) in
                if let bookIsbn = book.isbn {
                    paramSlug += "\(bookIsbn),"
                }
            }
            paramSlug.removeLast()
            paramSlug += "/"
            return paramSlug
        }
    }
    
    
    func getDiscounts(completion: @escaping () -> ()) {
        let urlString = baseURLString+getURLParams()+discountsEndPoint
        AF.request(urlString , method: .get).responseJSON { (response) in
        switch response.result {
            case .success:
                let jsonObject = (response.value as? [String:Any])?["offers"]
                if let discounts = Mapper<Discount>().mapArray(JSONObject: jsonObject) {
                    self.discounts = discounts
                }
            completion()
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }
    
    func getDiscountValue (of discount: Discount) -> Float {
        let totalPrice = sharedCart.getTotalPrice()
        var discountPrice: Float = 0

        switch discount.type! {
            case .percentage:
                discountPrice = totalPrice * discount.value! / 100
                break;
            case .minus:
                discountPrice = discount.value!
                break;
            case .slice:
                if ( totalPrice >= discount.sliceValue! ) {
                    discountPrice = discount.value!
                }
                break;
        }
        return discountPrice
    }
    
    func getBestDiscountValue() -> Float {
        var bestDiscountValue: Float = 0
        self.discounts?.forEach({ (discount) in
            if ( self.getDiscountValue(of: discount) >= bestDiscountValue) {
                bestDiscountValue = self.getDiscountValue(of: discount)
            }
        })
        return bestDiscountValue
    }
    
    func getBestFinalPrice() -> Float {
        return sharedCart.getTotalPrice() - getBestDiscountValue()
    }
    
    
}
