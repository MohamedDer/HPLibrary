//
//  BookTableViewCell.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
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
    }
    
    func setupCellWith(book: Book) {
        self.book = book
        synopsisLabel.text = book.synopsis?.first
        titleLabel.text = book.title
        priceLabel.text = "\(book.price!) £"
        if let urlString = book.coverURLString {
            setupImageWith(URLString: urlString)
        }
    }
    
    func setupImageWith(URLString: String)  {
        let url = URL(string: URLString)
        if let url = url {
            coverImageView.kf.setImage(with: url)
        }
    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        if let book = self.book {
            AppServices.cartService.sharedCart.add(book: book)
            showPromptWith(message: "Book added")
        }
    }
    
    @IBAction func removeFromCart(_ sender: Any) {
        if let book = self.book {
            if (AppServices.cartService.sharedCart.contains(book: book)){
                AppServices.cartService.sharedCart.remove(book: book)
                showPromptWith(message: "Book removed")
            } else {
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
        self.addSubview(loader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            loader.hide(animated: true)
        }
    }
}
