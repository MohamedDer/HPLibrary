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
}
