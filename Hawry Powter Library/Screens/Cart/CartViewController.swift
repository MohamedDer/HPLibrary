//
//  CartViewController.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import MBProgressHUD
import UIKit

class CartViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var bestDiscountLabel: UILabel!
    @IBOutlet var finalPriceLabel: UILabel!

    var books: [Book]?
    var totalPrice: Float?
    var bestDiscountValue: Float?
    var finalPrice: Float?
    var loader = MBProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        AppServices.discountService.getDiscounts { error in
            if error != nil {
                self.showPromptWith(message: "Error loading cart. Try again later.")
            }
            else {
                self.books = CartService.shared.books
                self.removeRedendancy()
                self.totalPrice = CartService.shared.getTotalPrice()
                self.bestDiscountValue = AppServices.discountService.getBestDiscountValue()
                self.finalPrice = AppServices.discountService.getBestFinalPrice()
                self.updateViewData()
            }
        }
    }

    fileprivate func updateViewData() {
        tableView.reloadData()
        if let totalPrice = self.totalPrice, let bestDiscount = bestDiscountValue, let finalPrice = self.finalPrice {
            totalPriceLabel.text = "\(totalPrice) £"
            bestDiscountLabel.text = "\(bestDiscount) £"
            finalPriceLabel.text = "\(finalPrice) £"
        }
    }

    func removeRedendancy() {
        let filteredCart: Cart = Cart()
        if let books = books {
            books.forEach { cBook in
                if !filteredCart.contains(book: cBook) {
                    filteredCart.books.append(cBook)
                }
            }
        }
        books = filteredCart.books
    }

    fileprivate func showPromptWith(message: String) {
        loader.hide(animated: true)
        loader.animationType = .fade
        loader.mode = .text
        loader.label.text = message
        loader.show(animated: true)
        tableView.addSubview(loader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loader.hide(animated: true)
        }
    }
}
