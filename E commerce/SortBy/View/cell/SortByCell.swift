//
//  SortByCell.swift
//  Ecommerce
//
//  Created by Alok Ranjan on 04/02/24.
//

import UIKit

class SortByCell: UITableViewCell {

    @IBOutlet weak var sortingLabel: UILabel!
    
    func configureCell(data: SortBYData) {
        sortingLabel.text = data.rawValue
    }
    
}
