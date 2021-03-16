//
//  SignInViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/08.
//

import Foundation
import UIKit
import FirebaseAuth

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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
            if self.emailTextField.text == "이메일 입력" {
                self.emailTextField.text = ""
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "비밀번호 입력"{
                self.passwordTextField.isSecureTextEntry = true
                self.passwordTextField.text = ""
            }
        case self.rePasswordTextField:
            if self.rePasswordTextField.text == "비밀번호 재입력" {
                self.rePasswordTextField.isSecureTextEntry = true
                self.rePasswordTextField.text = ""
            }
        default:
            print("error")
        }
    }
    @IBAction func NextButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let rePassword = rePasswordTextField.text else {
            let alert = UIAlertController(title: "에러", message: "개발자에게 연락주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if password != rePassword {
            let alert = UIAlertController(title: "오류", message: "두 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user,error) in
            if error != nil {
                let alert = UIAlertController(title: "오류", message: "이메일 혹은 비밀번호를 확인해 주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            user?.user.sendEmailVerification(completion: nil)
            guard let nextView = self.storyboard?.instantiateViewController(identifier: "SignInImageNickname") else {return}
            self.navigationController?.pushViewController(nextView, animated: true)
            
            
        }
    }
}
