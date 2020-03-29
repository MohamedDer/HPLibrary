//
//  CartTableViewCell.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 29/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(book: Book) {
        self.quantityLabel.text = "\(AppServices.cartService.sharedCart.getQuantityOf(book: book))"
        self.titleLabel.text = "\(book.title ?? "")"
        self.priceLabel.text = "\(book.price ?? 0) £"
        self.selectionStyle = .none
    }

}
