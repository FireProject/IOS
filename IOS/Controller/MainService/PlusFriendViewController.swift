//
//  PlusFriendViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/22.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class PlusFriendViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var friendEmailTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.friendEmailTextField.delegate = self
        self.warningLabel.textColor = .white
        self.warningLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = self.friendEmailTextField.text ?? ""
        if text == "" {
            self.friendEmailTextField.text = "친구 Email"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = self.friendEmailTextField.text ?? ""
        if text == "친구 Email" {
            self.friendEmailTextField.text = ""
        }
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func plusFriendButtonPressed(_ sender: Any) {
        let s = DispatchSemaphore(value: 0)
        var isExistEmail = false
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        guard let emailText = self.friendEmailTextField.text?.data(using: .utf8) else {
            return
        }
        let email = emailText.map({String(format:"%02x", $0)}).joined()

        
        ref.child("emailToUid").child(email).getData(completion: { (error,snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let uid = snapshot.value as! String
                userData.friends.append(uid)
                ref.child("users").child(Auth.auth().currentUser!.uid).child("friends").setValue(userData.friends)
                isExistEmail = true
            }
            else {
            }
            s.signal()
        })
        
        s.wait()
        if isExistEmail == false {
            self.warningLabel.text = "존재하지 않는 유저입니다."
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
