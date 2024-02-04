//
//  ProductCell.swift
//  E commerce
//
//  Created by Alok Ranjan on 02/02/24.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountedPriceLaabel: UILabel! {
        didSet {
            discountedPriceLaabel.textColor = .red
        }
    }
    
    
    func configure(data: Record) {
        self.productImageView.sd_setImage(with: URL(string: data.lgImage ?? ""), placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = data.productDisplayName ?? ""
        
        if let price = data.maximumPromoPrice, price > 0 {
            let attributeString =  NSMutableAttributedString(string: "$" + String(describing: data.maximumListPrice ?? 0.0))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSMakeRange(0, attributeString.length))
            priceLabel.attributedText = attributeString
            priceLabel.textColor = .gray
            discountedPriceLaabel.text = "$" + String(describing: data.maximumPromoPrice ?? 0.0)
            discountedPriceLaabel.isHidden = false
        } else {
            priceLabel.textColor = .red
            priceLabel.text = "$" + String(describing: data.maximumListPrice ?? 0.0)
            discountedPriceLaabel.isHidden = true
        }
    }
    
}
