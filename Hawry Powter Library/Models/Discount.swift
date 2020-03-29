//
//  Discount.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation
import ObjectMapper

class Discount: Mappable {
    
    enum DiscountType: String {
        case percentage = "percentage"
        case minus = "minus"
        case slice = "slice"
    }
    
    var type: DiscountType?
    var value: Float?
    var sliceValue: Float?
    
    func mapping(map: Map) {
        type    <- map["type"]
        value    <- map["value"]
        sliceValue    <- map["sliceValue"]
    }

    required init?(map: Map) {
    }
}
