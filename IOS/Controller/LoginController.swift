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
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] authResult, error in
            guard self != nil else {
                return
            }
        }
        if Auth.auth().currentUser != nil {
            let board = UIStoryboard(name: "FireService", bundle: nil)
            let serviceView = board.instantiateViewController(identifier: "service")
            serviceView.modalPresentationStyle = .fullScreen
            present(serviceView, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "로그인 실패", message: "이메일 혹은 비밀번호를 확인해 주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
