//
//  ViewController.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        cartButton.layer.cornerRadius = cartButton.frame.height / 2
        //TO DO: Make an App Services to group all services
        let bs = BooksService().sharedBooksService
        bs.fetchBooks {
            if let books = bs.getBooks() {
                self.books = books
            }
            self.tableView.reloadData()
        }
        //set loader
        
    }


}

