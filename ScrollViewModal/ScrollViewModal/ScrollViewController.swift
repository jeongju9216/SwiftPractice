//
//  ScrollViewController.swift
//  ScrollViewModal
//
//  Created by 유정주 on 2022/10/05.
//

import UIKit

class ScrollViewController: UIViewController {
    
    var tableView: UITableView!
    var items: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items = (1...100).map { $0 }
        
        setupTableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .blue
        tableView.bounces = false
        
        self.view.addSubview(tableView)
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }

}

extension ScrollViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = "i: \(items[indexPath.row])"
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = title
        
        return cell
    }

}

extension ScrollViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
