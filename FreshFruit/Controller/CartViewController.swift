//
//  CartViewController.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 06/10/20.
//

import UIKit
import SDWebImage

var fruitListCart1 = [FruitCart]()

class CartViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var tanggalKirimTextField: UITextField!
    @IBOutlet weak var tableCart: UITableView!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var grandTotal = 0
    let cellId = "cartTableViewCell"
    var currentDate: String = ""
    
    //MARK: - default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tanggalKirimTextField.delegate = self
        tableCart.delegate = self
        tableCart.dataSource = self
        tableCart.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        sumSubTotal()
        setupDatePickerToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableCart.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableCart.reloadData()
        sumSubTotal()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            currentDate = "\(day) \(month) \(year)"
        }
    }
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        if tanggalKirimTextField.text == "" {
            let alert = UIAlertController(title: "Confirm", message: "Silahkan pilih tanggal dikirim", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Confirm", message: "Pesanan Kamu berhasil! Tunggu saja di rumah #stayathome", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Custom Methods
    func sumSubTotal() {
        grandTotal = 0
        for item in fruitListCart1 {
            grandTotal = grandTotal + (Int(Double(item.price)! * Double(item.qty)!))
        }
        grandTotalLabel.text = formatNumber(price: grandTotal)
        
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
    
    func setupDatePickerToolbar() {
        datePicker.isHidden = true
        datePicker.backgroundColor = .white
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(datePickerDone))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tanggalKirimTextField.inputView = datePicker
        tanggalKirimTextField.inputAccessoryView = toolBar
    }
    
    @objc func datePickerDone(){
        datePicker.isHidden = true
        tanggalKirimTextField.text = currentDate
        print("ini current Date: \(currentDate)")
        tanggalKirimTextField.resignFirstResponder()
    }
    
}

//MARK: - TableViewDelegate & DataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CartTableViewCell
        if fruitListCart1.count != 0 {
            cell.namaLabel?.text = fruitListCart1[indexPath.row].nameFruit
            cell.hargaLabel?.text = formatNumber(price: Int(fruitListCart1[indexPath.row].price)!)
            cell.quantityLabel?.text = fruitListCart1[indexPath.row].qty
            cell.subTotalLabel?.text = formatNumber(price: Int(Double(fruitListCart1[indexPath.row].price)! * Double(fruitListCart1[indexPath.row].qty)!))
            cell.fruitImageView?.sd_setImage(with: URL(string: fruitListCart1[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        } else {
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitListCart1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

//MARK: - UITextFieldDelegate
extension CartViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tanggalKirimTextField {
            datePicker.isHidden = false
        }
    }
}
