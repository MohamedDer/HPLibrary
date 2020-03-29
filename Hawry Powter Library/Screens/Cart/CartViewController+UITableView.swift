//
//  File.swift
//  Hawry Powter Library
//
//  Created by Mohamed Derkaoui on 29/03/2020.
//  Copyright © 2020 Mohamed Derkaoui. All rights reserved.
//

import Foundation
import UIKit


extension CartViewController: UITableViewDelegate, UITableViewDataSource {
     
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as? CartTableViewCell {
            if let books = self.books {
                cell.configureWith(book: books[indexPath.row])
                return cell
                }
            }
            
        return UITableViewCell()
    }
    
    
    
}
