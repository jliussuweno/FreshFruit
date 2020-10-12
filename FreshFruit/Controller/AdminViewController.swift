//
//  AdminViewController.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 09/10/20.
//

import UIKit

class AdminViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var addProductButton: UIButton!
    let cellId = "productTableViewCell"
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    //MARK: - Custom Methods
    func formatNumber(price: Int) -> String {
        let formatter = NumberFormatter()
        var strResult = "Rp "
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        if let formattedTipAmount = formatter.string(from: price as NSNumber) {
            strResult = "Rp \(formattedTipAmount)"
        } else {
            strResult = "Rp 1.000"
        }
        return strResult
    }
    
}

extension AdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductTableViewCell
        let currentLastItem = fruitList[indexPath.row]
        cell.namaProductLabel.text = currentLastItem.nameFruit
        cell.hargaProductLabel.text = formatNumber(price: Int(currentLastItem.price)!)
        cell.productImageView.sd_setImage(with: URL(string: currentLastItem.image), placeholderImage: UIImage(named: "placeholder.png"))
        cell.stockLabel.text = currentLastItem.stock
        cell.selectionStyle = .none
        cell.deleteButton.tag = indexPath.row
        cell.changePriceButton.tag = indexPath.row
        cell.changeStockButton.tag = indexPath.row
        return cell
    }
    
    
}
