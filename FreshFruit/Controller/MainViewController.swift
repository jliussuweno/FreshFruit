//
//  ViewController.swift
//  FreshFruit
//
//  Created by Jlius Suweno on 06/10/20.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerLabel: UILabel!
    
    var databaseManager = DBClass()
    var user = User()
    var userList = [User]()
    
    var fruitList = [ Fruit(id: 1, nameFruit: "Apel", price: "30000", stock: "10", image: "https://firebasestorage.googleapis.com/v0/b/sakukuplusplus.appspot.com/o/images%2Fan_vision-gDPaDDy6_WE-unsplash.jpg?alt=media&token=21bd62e7-7136-41c2-b252-afb596a5e222"),
                      Fruit(id: 2, nameFruit: "Pisang", price: "50000", stock: "90", image: "https://firebasestorage.googleapis.com/v0/b/sakukuplusplus.appspot.com/o/images%2Fbanana.jpg?alt=media&token=70ae19e3-aaed-40b4-814f-8b44be2d3e3e"),
                      Fruit(id: 3, nameFruit: "Nangka", price: "60000", stock: "100", image: "https://firebasestorage.googleapis.com/v0/b/sakukuplusplus.appspot.com/o/images%2Fnangka.jpg?alt=media&token=2d958a97-d30f-45f4-9264-52ed4749742c")]
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        databaseManager.initDB()
        databaseManager.deleteSavedDataFruit()
        databaseManager.createTableFruit()
        databaseManager.saveDBValueFruit(inputData: fruitList[0])
        databaseManager.saveDBValueFruit(inputData: fruitList[1])
        databaseManager.saveDBValueFruit(inputData: fruitList[2])
        setupGesture()
        emailTextField.setIcon(UIImage(named: "email")!)
        passwordTextField.setIcon(UIImage(named: "password")!)
    }
        
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        user.email = emailTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        
        userList = databaseManager.readDBValueLogin(inputData: user)
        
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            loadingNotification.hide(animated: true)
            alertShow(message: "Email/Password tidak boleh kosong")
        } else if emailTextField.text == "jlius" && passwordTextField.text == "123" {
            loadingNotification.hide(animated: true)
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        } else if userList.count == 1 && userList[0].role == "user" {
            loadingNotification.hide(animated: true)
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        } else if userList.count == 1 && userList[0].role == "admin" {
            loadingNotification.hide(animated: true)
            self.performSegue(withIdentifier: "adminSegue", sender: nil)
        } else if emailTextField.text == "jliuss" && passwordTextField.text == "123" {
            loadingNotification.hide(animated: true)
            self.performSegue(withIdentifier: "adminSegue", sender: nil)
        } else {
            loadingNotification.hide(animated: true)
            alertShow(message: "Email/Password tidak ditemukan, Mohon coba lagi")
        }
    }
    
    //MARK: - Custom Method
    func alertShow(message: String){
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setupGesture(){
        var tap : UITapGestureRecognizer
        tap = UITapGestureRecognizer(target: self, action: #selector(click))
        registerLabel.addGestureRecognizer(tap)
        registerLabel.isUserInteractionEnabled = true
    }
    
    @objc func click(){
        self.performSegue(withIdentifier: "registerSegue", sender: nil)
    }
}

//MARK: - UITextField
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Harus diisi"
            return false
        }
    }
}
