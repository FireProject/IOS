//
//  SearchEmailPasswordViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
class SearchEmailPasswordViewController: UIViewController {
    
    @IBOutlet weak var tmpText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func tmpBUtton(_ sender: Any) {
        guard let email = tmpText.text else {
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
}
