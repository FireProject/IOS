//
//  LoginController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/08.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController : UIViewController , UITextFieldDelegate {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var hasNickname = true
    
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
            
            if let error = error  {
                var errorMessage = ""
                switch error ._code {
                case AuthErrorCode.invalidEmail.rawValue:
                    errorMessage = "이메일 형식을 확인해 주세요"
                    break
                case AuthErrorCode.userDisabled.rawValue:
                    errorMessage = "해당계정은 사용이 중지되었습니다."
                    break
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "비밀번호 확인해주세요"
                    break
                case AuthErrorCode.userNotFound.rawValue:
                    errorMessage = "존재하지 않는 이메일입니다."
                    break
                default:
                    print(error)
                    errorMessage = "개발자에게 연락주세요"
                    break
                }
                
                let alert = UIAlertController(title: "오류", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard let user = user?.user else {
                return
            }
            if user.isEmailVerified == false {
                let alert = UIAlertController(title: "이메일 인증이 되지않았습니다.", message: "메일을 재전송 했습니다. 확인해 주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                user.sendEmailVerification(completion: {
                    error in
                })
                return
            }
                
            let storyboard = UIStoryboard(name: "BurningUpMain", bundle: nil)
            let pushController = storyboard.instantiateViewController(withIdentifier: "BurningUpMainNavigation")
            pushController.modalPresentationStyle = .fullScreen
            self.present(pushController, animated: true, completion: nil)
        }
    }
}
