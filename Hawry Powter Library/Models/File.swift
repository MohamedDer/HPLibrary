//
//  File.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation

class Cart {
    
    var books: [Book] = []
    
    //MARK: Utils
    func add(book: Book) {
        self.books.append(book)
    }
    
    
    func remove(book: Book) {

        let bookIndex = self.books.firstIndex { (cBook) -> Bool in
            cBook.isbn == book.isbn
        }
        if let index = bookIndex {
            self.books.remove(at: index)
        }
        
    }
    
    
}
