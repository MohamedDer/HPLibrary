//
//  Book.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation
import ObjectMapper


class Book: Mappable {
    
    var isbn: String?
    var title: String?
    var price: Int?
    var coverURLString: String?
    var synopsis: [String]?

    
    func mapping(map: Map) {
        isbn    <- map["isbn"]
        title    <- map["title"]
        price    <- map["price"]
        coverURLString    <- map["cover"]
        synopsis    <- map["synopsis"]
    }

    required init?(map: Map) {
    }
    
    
    
    
}
