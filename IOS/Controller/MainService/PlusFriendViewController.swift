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
        
        guard let email = self.friendEmailTextField.text else {
            return
        }
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        ref.child("emailToUid").child(email).getData(completion: { (error,snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                self.warningLabel.text = ""
            }
            else {
                self.warningLabel.text = "존재하지 않습니다."
            }
        })
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
        
        guard let email = self.friendEmailTextField.text else {
            return
        }
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        ref.child("emailToUid").child(email).getData(completion: { (error,snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                let uid = snapshot.value as! String
                self.warningLabel.text = ""
                userData.friends.append(uid)
                ref.child("users").child(Auth.auth().currentUser!.uid).child("friends").setValue(userData.friends)
            }
            else {
                self.warningLabel.text = "존재하지 않습니다."
            }
        })
    }
}
