//
//  SignUpController.swift
//  IOS
//
//  Created by 장대호 on 2021/02/23.
//


import UIKit
import FirebaseAuth
import Firebase
class SignUpController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func SignUpButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text  else {
            let alert = UIAlertController(title: "회원가입 실패", message: "개발자에게 연락주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {(user,error) in
            if error != nil {
                let alert = UIAlertController(title: "회원가입 실패", message: "개발자에게 연락주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if user != nil {
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("user").setValue(["uid":user?.user.uid])
                
                let board = UIStoryboard(name: "FireService", bundle: nil)
                let serviceView = board.instantiateViewController(identifier: "service")
                serviceView.modalPresentationStyle = .fullScreen
                UserDefaults.standard.setValue("email", forKey: email)
                UserDefaults.standard.setValue("password", forKey: password)
                self.present(serviceView, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "회원가입 실패", message: "이메일 혹은 비밀번호를 확인해주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in}
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
