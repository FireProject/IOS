//
//  SignInViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/08.
//

import Foundation
import UIKit
class SignInEmailViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        emailTextField.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            if self.emailTextField.text == "" {
                self.emailTextField.text = "이메일 입력"
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "" {
                self.passwordTextField.isSecureTextEntry = false
                self.passwordTextField.text = "비밀번호 입력"
            }
        case self.rePasswordTextField:
            if self.rePasswordTextField.text == "" {
                self.rePasswordTextField.isSecureTextEntry = false
                self.rePasswordTextField.text = "비밀번호 재입력"
            }
        default:
            print("error")
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            self.emailTextField.text = ""
        case self.passwordTextField:
            self.passwordTextField.isSecureTextEntry = true
            self.passwordTextField.text = ""
        case self.rePasswordTextField:
            self.rePasswordTextField.isSecureTextEntry = true
            self.rePasswordTextField.text = ""
        default:
            print("error")
        }
    }
    @IBAction func NextButtonPressed(_ sender: Any) {
    }
}
