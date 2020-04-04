//
//  BookTableViewCell.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Kingfisher
import MBProgressHUD
import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    @IBOutlet var addButton: UIButton!
    @IBOutlet var removeButton: UIButton!

    var book: Book?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellLayouts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCellLayouts() {
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        addButton.layer.cornerRadius = addButton.layer.frame.height / 2
        removeButton.layer.cornerRadius = removeButton.layer.frame.height / 2
    }

    func setupCellWith(book: Book) {
        self.book = book
        synopsisLabel.text = book.synopsis?.first
        titleLabel.text = book.title
        if let price =  book.price {
            priceLabel.text = "\(price) £"
        }
        if let urlString = book.coverURLString {
            setupImageWith(URLString: urlString)
        }
    }

    func setupImageWith(URLString: String) {
        let url = URL(string: URLString)
        if let url = url {
            coverImageView.kf.setImage(with: url)
        }
    }

    @IBAction func addToCart(_: Any) {
        if let book = self.book {
            CartService.shared.add(book: book)
            showPromptWith(message: "Book added")
        }
    }

    @IBAction func removeFromCart(_: Any) {
        if let book = self.book {
            if CartService.shared.contains(book: book) {
                CartService.shared.remove(book: book)
                showPromptWith(message: "Book removed")
            }
            else {
                showPromptWith(message: "Not in cart")
            }
        }
    }

    fileprivate func showPromptWith(message: String) {
        let loader = MBProgressHUD()
        loader.animationType = .fade
        loader.mode = .text
        loader.label.text = message
        loader.show(animated: true)
        addSubview(loader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            loader.hide(animated: true)
        }
    }
}
