//
//  LoginController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/08.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController : UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            if self.emailTextField.text == "Email"{
                self.emailTextField.text = ""
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "Password" {
                self.passwordTextField.isSecureTextEntry = true
                self.passwordTextField.text = ""
            }
        default:
            print("error")
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            if self.emailTextField.text == "" {
                self.emailTextField.text = "Email"
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "" {
                self.passwordTextField.isSecureTextEntry = false
                self.passwordTextField.text = "Password"
            }
        default:
            print("error")
        }
    }
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user,error) in
            if error != nil {
                return
            }
            
            let storyboard = UIStoryboard(name: "BurningUpMain", bundle: nil)
            let pushController = storyboard.instantiateViewController(withIdentifier: "BurningUpMain")
            self.navigationController?.pushViewController(pushController, animated: true)
        }
    }
    @IBAction func SignInButtonPressed(_ sender: Any) {
        self.navigationController?.pushViewController(SignInEmailViewController(), animated: true)
    }
    @IBAction func SearchEmailPasswordButtonPressed(_ sender: Any) {
    }
}
