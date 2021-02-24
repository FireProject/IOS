//
//  LoginController.swift
//  IOS
//
//  Created by 장대호 on 2021/02/23.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text  else {
            let alert = UIAlertController(title: "로그인 실패", message: "개발자에게 연락주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if signIn(userEmail: email, userPassword: password) == true {
            let board = UIStoryboard(name: "FireService", bundle: nil)
            let serviceView = board.instantiateViewController(identifier: "service")
            serviceView.modalPresentationStyle = .fullScreen
            self.present(serviceView, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "로그인 실패", message: "이메일 혹은 비밀번호를확인해 주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
