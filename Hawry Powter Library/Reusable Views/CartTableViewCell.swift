//
//  CartTableViewCell.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 29/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureWith(book: Book) {
        let quantity = CartService.shared.getQuantityOf(book: book)
        quantityLabel.text = "\(quantity)"
        titleLabel.text = "\(book.title ?? "")"
        priceLabel.text = "\((book.price ?? 0) * Float(quantity)) £"
        selectionStyle = .none
    }
}
