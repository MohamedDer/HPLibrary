//
//  ViewController.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    
    var books: [Book]?
     let loader = MBProgressHUD()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        cartButton.layer.cornerRadius = cartButton.frame.height / 2
        setupLoader()
        loadBooks()
        
    }
    
    fileprivate func loadBooks() {
        let bookservice = AppServices.booksService
        bookservice.fetchBooks {
            if let books = bookservice.getBooks() {
                self.books = books
            }
            self.updateView()
        }
    }
    
    fileprivate func setupLoader() {
        loader.animationType = .fade
        loader.mode = .indeterminate
        loader.label.text = "Loading..."
        loader.show(animated: true)
        self.view.addSubview(loader)
    }
    
    fileprivate func updateView() {
        self.tableView.reloadData()
        self.loader.hide(animated: true)
    }
    

}

