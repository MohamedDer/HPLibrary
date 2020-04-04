//
//  CartService.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Alamofire
import Foundation
import ObjectMapper

class DiscountService {
    let baseURLString = "http://henri-potier.xebia.fr/books/"
    let discountsEndPoint = "commercialOffers"

    var discounts: [Discount]?

    var sharedCart = CartService.shared

    func getURLParams() -> String {
        if sharedCart.books.isEmpty {
            return ""
        }
        else {
            var paramSlug = ""
            sharedCart.books.forEach { book in
                if let bookIsbn = book.isbn {
                    paramSlug += "\(bookIsbn),"
                }
            }
            paramSlug.removeLast()
            paramSlug += "/"
            return paramSlug
        }
    }

    func getDiscounts(completion: @escaping (_ error: Error?) -> Void) {
        let urlString = baseURLString + getURLParams() + discountsEndPoint
        AF.request(urlString, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let jsonObject = (response.value as? [String: Any])?["offers"]
                if let discounts = Mapper<Discount>().mapArray(JSONObject: jsonObject) {
                    self.discounts = discounts
                }
                completion(nil)
            case let .failure(error):
                completion(error)
                print(error.errorDescription)
            }
        }
    }

    func getDiscountValue(of discount: Discount) -> Float {
        let totalPrice = sharedCart.getTotalPrice()
        var discountPrice: Float = 0
        if let discountType = discount.type, let discountValue = discount.value {
            switch discountType {
            case .percentage:
                discountPrice = totalPrice * discountValue / 100
            case .minus:
                discountPrice = discountValue
            case .slice:
                if let discountSlice = discount.sliceValue {
                    if totalPrice >= discountSlice {
                        discountPrice = discountValue
                    }
                }
            }
        }
        return discountPrice
    }

    func getBestDiscountValue() -> Float {
        var bestDiscountValue: Float = 0
        discounts?.forEach { discount in
            if self.getDiscountValue(of: discount) >= bestDiscountValue {
                bestDiscountValue = self.getDiscountValue(of: discount)
            }
        }
        return bestDiscountValue
    }

    func getBestFinalPrice() -> Float {
        return sharedCart.getTotalPrice() - getBestDiscountValue()
    }
}
