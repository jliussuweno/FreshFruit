//
//  ProductTableViewCell.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 09/10/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var namaProductLabel: UILabel!
    @IBOutlet weak var hargaProductLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var changePriceButton: UIButton!
    @IBOutlet weak var changeStockButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        fruitList.remove(at: sender.tag)
    }
    
    @IBAction func changePricePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change Price", message: "Enter new Price", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = fruitList[sender.tag].price
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
        }))
        
    }
    
    @IBAction func changeStockPressed(_ sender: UIButton) {
        
    }
}
