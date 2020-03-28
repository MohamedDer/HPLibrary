//
//  BookTableViewCell.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 28/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import UIKit
import Kingfisher

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var book: Book?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupCellLayouts()
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
    
    
}
