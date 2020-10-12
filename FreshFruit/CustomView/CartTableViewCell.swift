//
//  CartTableViewCell.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 08/10/20.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var hargaLabel: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var fruitImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
