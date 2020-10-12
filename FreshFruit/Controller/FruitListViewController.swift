//
//  FruitListViewController.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 06/10/20.
//

import UIKit
import SDWebImage

var fruitList = [Fruit]()

class FruitListViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var fruitTableView: UITableView!
    let cellId = "fruitTableViewCell"
    var refresher: UIRefreshControl!
    var databaseManager = DBClass()
    var fruitCartList = [FruitCart]()
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        fruitTableView.delegate = self
        fruitTableView.dataSource = self
        databaseManager.initDB()
        fruitList = databaseManager.readDBValueFruit()
        fruitTableView.register(UINib(nibName: "FruitTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    //MARK: - Custom Methods
    @objc func updateQuantity(_ sender: UIButton) {
        
        let tag = (sender.tag - 1) / 2
        let lastItem = fruitList[tag]
        let namefruit = lastItem.nameFruit
        let price = lastItem.price
        let stock = lastItem.stock
        let image = lastItem.image
        let qty = lastItem.qty
        
        if stock < qty {
            let alert = UIAlertController(title: "Stock", message: "Stock tidak cukup", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if fruitCartList.count == 0 {
                fruitCartList.append(FruitCart(nameFruit: namefruit, price: price, qty: qty, image: image, stock: stock))
            } else {
                for (index, item) in fruitCartList.enumerated() {
                    if item.nameFruit.contains(namefruit) {
                        if Int(qty) == 0 {
                            fruitCartList.remove(at: index)
                        } else {
                            item.qty = qty
                        }
                    }
                    else {
                        fruitCartList.append(FruitCart(nameFruit: namefruit, price: price, qty: qty, image: image, stock: stock))
                    }
                }
            }
        }
    }
    
    @objc func updateQuantityDec(_ sender: UIButton) {
        let lastItem = fruitList[sender.tag / 2]
        let namefruit = lastItem.nameFruit
        let price = lastItem.price
        let stock = lastItem.stock
        let image = lastItem.image
        let qty = lastItem.qty
        
        if stock < qty {
            let alert = UIAlertController(title: "Stock", message: "Stock tidak cukup", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if fruitCartList.count == 0 {
                fruitCartList.append(FruitCart(nameFruit: namefruit, price: price, qty: qty, image: image, stock: stock))
            } else {
                for (index, item) in fruitCartList.enumerated() {
                    if item.nameFruit.contains(namefruit) {
                        if Int(qty) == 0 {
                            fruitCartList.remove(at: index)
                        } else {
                            item.qty = qty
                        }
                    }
                    else {
                        fruitCartList.append(FruitCart(nameFruit: namefruit, price: price, qty: qty, image: image, stock: stock))
                    }
                }
            }
        }
    }
    
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

//MARK: - UITableViewDelegate & Data Source
extension FruitListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FruitTableViewCell
        let currentLastItem = fruitList[indexPath.row]
        cell.nameFruitLabel.text = currentLastItem.nameFruit
        cell.priceLabel.text = formatNumber(price: Int(currentLastItem.price)!)
        cell.stockLabel.text = currentLastItem.stock
        cell.fruitImage.sd_setImage(with: URL(string: currentLastItem.image), placeholderImage: UIImage(named: "placeholder.png"))
        cell.quantityLabel.text = currentLastItem.qty
        cell.selectionStyle = .none
        cell.decrementButton.tag = indexPath.row * 2
        cell.incrementButton.tag = indexPath.row * 2 + 1
        cell.incrementButton.addTarget(self, action: #selector(updateQuantity(_:)), for:.touchUpInside)
        cell.decrementButton.addTarget(self, action: #selector(updateQuantityDec(_:)), for:.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitTableViewCell") as! FruitTableViewCell
        
        if Double(cell.quantityLabel.text!)! > Double(fruitList[indexPath.row].stock)! {
            let ac = UIAlertController(title: "Stock is not Avaliable", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Quantity updated", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
}

//MARK: - UITabBarControllerDelegate
extension FruitListViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            for (key, item) in fruitCartList.enumerated() {
                if Int(item.qty) == 0 {
                    fruitCartList.remove(at: key)
                }
            }
            fruitListCart1 = fruitCartList
        }
    }
}
