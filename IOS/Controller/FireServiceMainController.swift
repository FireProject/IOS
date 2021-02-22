//
//  FireServiceMainController.swift
//  IOS
//
//  Created by 장대호 on 2021/02/23.
//

import UIKit
import FirebaseAuth
class FireServiceMainController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func LogoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }
}
