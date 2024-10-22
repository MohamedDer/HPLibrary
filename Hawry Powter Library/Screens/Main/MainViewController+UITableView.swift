import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: .main), forCellReuseIdentifier: "bookTableViewCell")
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 120, right: 0)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return books?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "bookTableViewCell", for: indexPath) as? BookTableViewCell {
            if let books = self.books {
                cell.setupCellWith(book: books[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 160
    }
}
