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
        /*let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        Auth.auth().sendSignInLink(toEmail:emailTextField.text ?? "",
                                   actionCodeSettings: actionCodeSettings) { error in
          // ...
            if let error = error {
              print("error")
              return
            }
            // The link was successfully sent. Inform the user.
            // Save the email locally so you don't need to ask the user for it again
            // if they open the link on the same device.
           // UserDefaults.standard.set(self.emailTextField.text ?? "", forKey: "Email")
            // ...
        }*/
    }
}
