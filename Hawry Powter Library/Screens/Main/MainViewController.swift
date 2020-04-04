//
//  ViewController.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import MBProgressHUD
import UIKit

class MainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cartButton: UIButton!

    var books: [Book]?
    var loader = MBProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCartButton()
        setupLoader()
        loadBooks()
    }

    fileprivate func loadBooks() {
        let bookservice = AppServices.booksService
        bookservice.fetchBooks { error in
            if error != nil {
                self.showPromptWith(message: "Error while loading data. Try again later")
            }
            else {
                if let books = bookservice.getBooks() {
                    self.books = books
                }
                self.updateView()
            }
        }
    }

    fileprivate func setupLoader() {
        loader.animationType = .fade
        loader.mode = .indeterminate
        loader.label.text = "Loading..."
        loader.show(animated: true)
        view.addSubview(loader)
    }

    fileprivate func updateView() {
        tableView.reloadData()
        loader.hide(animated: true)
    }

    fileprivate func setupCartButton() {
        cartButton.layer.cornerRadius = cartButton.frame.height / 2
        cartButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        cartButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        cartButton.layer.shadowOpacity = 1.0
        cartButton.layer.shadowRadius = 10.0
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender _: Any?) -> Bool {
        if identifier == "cartSegue" {
            if CartService.shared.books.isEmpty {
                showPromptWith(message: "Empty cart")
                return false
            }
        }
        return true
    }

    fileprivate func showPromptWith(message: String) {
        loader.hide(animated: true)
        loader.animationType = .fade
        loader.mode = .text
        loader.label.text = message
        loader.show(animated: true)
        view.addSubview(loader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.hide(animated: true)
        }
    }
}
