//
//  RegisterViewController.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 07/10/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var rolePickerView: UIPickerView!
    var databaseManager = DBClass()
    var userList = [User]()
    var user: User = User()
    var rolePickerData = ["user", "admin"]
    
    //MARK: - Defaults Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFieldGroup: [UITextField] = [fullNameTextField, emailTextField, passwordTextField, confirmPasswordTextField, roleTextField]
        databaseManager.initDB()
        databaseManager.createTableUser()
        for item in textFieldGroup {
            item.delegate = self
        }
        rolePickerView.delegate = self
        rolePickerView.dataSource = self
        setupPickerToolbar()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        user.email = emailTextField.text ?? ""
        userList = databaseManager.readDBValueRegister(inputData: user)
        
        if fullNameTextField.text == "" {
            showAlert(message: "Full Name harus diisi", segue: "stayHereSegue")
        } else if emailTextField.text == "" {
            showAlert(message: "Email harus diisi", segue: "stayHereSegue")
        } else if passwordTextField.text == "" {
            showAlert(message: "Password harus diisi", segue: "stayHereSegue")
        } else if confirmPasswordTextField.text == "" {
            showAlert(message: "Confirm Password harus diisi", segue: "stayHereSegue")
        } else if roleTextField.text == "" {
            showAlert(message: "Role harus diisi", segue: "stayHereSegue")
        } else if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(message: "Password dan Confirm Password tidak sama", segue: "stayHereSegue")
        } else if userList.count == 1 {
            showAlert(message: "Register berhasil", segue: "loginSegue")
        } else if userList.count == 0 {
            showAlert(message: "Email sudah terdaftar, silahkan login", segue: "loginSegue")
        }
    }
    
    //MARK: - Custom Methods
    func showAlert(message: String, segue: String){
        let alert = UIAlertController(title: "Register", message: message, preferredStyle: .alert)
        if segue == "loginSegue" {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in self.performSegue(withIdentifier: segue, sender: nil) } ))
        } else {
            alert.addAction(UIAlertAction(title: "Kembali", style: .default, handler: nil))
        }
        self.present(alert, animated: true)
    }
    
    func setupPickerToolbar() {
        rolePickerView.isHidden = true
        rolePickerView.backgroundColor = .white
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(pickerDone))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        roleTextField.inputView = rolePickerView
        roleTextField.inputAccessoryView = toolBar
    }
    
    @objc func pickerDone(){
        rolePickerView.isHidden = true
        roleTextField.text = rolePickerData[rolePickerView.selectedRow(inComponent: 0)]
        roleTextField.resignFirstResponder()
    }
    
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Harus diisi"
            return false
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == roleTextField {
            rolePickerView.isHidden = false
        }
        
    }
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rolePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rolePickerData[row]
    }
    
}
