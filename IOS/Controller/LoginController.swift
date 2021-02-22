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
                print("here first?")
                return
            }
        }
        
        
    }
}
