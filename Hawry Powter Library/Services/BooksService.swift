//
//  BooksService.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BooksService {
    
    let baseURLString = "http://henri-potier.xebia.fr/books"
    
    fileprivate var _sharedBookService: BooksService?
    public var sharedBooksService: BooksService {
        get {
            if let shared = _sharedBookService {
                return shared
            } else {
                let shared = BooksService()
                _sharedBookService = shared
                return shared
            }
        }
        set {
            _sharedBookService = newValue
        }
    }
    
    fileprivate var books: [Book]?

    //MARK: Utils
    func getBooks() -> [Book]? {
        return self.books
    }
    
    func fetchBooks(completion : @escaping ()->())  {
        AF.request(baseURLString, method: .get).responseJSON { (response) in
        switch response.result {
            case .success:
                let jsonObject = (response.value as? [Any])
                if let books = Mapper<Book>().mapArray(JSONObject: jsonObject) {
                    self.books = books
                }
            completion()
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }
}
