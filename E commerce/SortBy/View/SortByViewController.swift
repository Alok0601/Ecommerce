//
//  SortByViewController.swift
//  Ecommerce
//
//  Created by Alok Ranjan on 04/02/24.
//

import UIKit

class SortByViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SortByProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SortByCell", bundle: nil), forCellReuseIdentifier: "SortByCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortBYData.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell", for: indexPath) as! SortByCell
        cell.configureCell(data: SortBYData.allCases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSortByOption(data: SortBYData.allCases[indexPath.row])
    }
}
