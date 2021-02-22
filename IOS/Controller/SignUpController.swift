//
//  SignUpController.swift
//  IOS
//
//  Created by 장대호 on 2021/02/23.
//


import UIKit
import FirebaseAuth

class SignUpController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func SignUpButton(_ sender: Any) {
        let actionCodeSetting = ActionCodeSettings.init()
        actionCodeSetting.handleCodeInApp = true
        Auth.auth().sendSignInLink(toEmail: emailTextField.text ?? "", actionCodeSettings: actionCodeSetting) {
            error in
            if let error = error {
                print(error)
                return
            }
        }
    }
}
