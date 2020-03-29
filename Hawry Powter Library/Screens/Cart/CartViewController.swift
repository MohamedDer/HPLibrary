//
//  CartViewController.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var bestDiscountLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
   
    var books: [Book]?
    var totalPrice: Float?
    var bestDiscountValue: Float?
    var finalPrice: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        AppServices.discountService.getDiscounts {
            self.books = AppServices.cartService.sharedCart.books
            self.removeRedendancy()
            self.totalPrice = AppServices.cartService.sharedCart.getTotalPrice()
            self.bestDiscountValue = AppServices.discountService.getBestDiscountValue()
            self.finalPrice = AppServices.discountService.getBestFinalPrice()
            self.updateViewData()
        }

    }
    
    fileprivate func updateViewData() {
        tableView.reloadData()
        if let totalPrice = self.totalPrice, let bestDiscount = self.bestDiscountValue, let finalPrice = self.finalPrice {
            totalPriceLabel.text = "\(totalPrice) £"
            bestDiscountLabel.text = "\(bestDiscount) £"
            finalPriceLabel.text = "\(finalPrice) £"
        }
    }
    
    func removeRedendancy() {
        let filteredCart: Cart = Cart()
        if let books = books {
            books.forEach { (cBook) in
                if (!filteredCart.contains(book: cBook)) {
                    filteredCart.books.append(cBook)
                }
            }
        }
        self.books = filteredCart.books
    }

}
