//
//  SearchEmailPasswordViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func sendMailButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email, completion: {
            error in})
        let alert = UIAlertController(title: "메일 전송", message: "메일을 전송 했습니다. 확인해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
