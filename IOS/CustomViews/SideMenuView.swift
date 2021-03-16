//
//  SideMenuView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/16.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SideMenuView: UIView {
    weak var parentViewController: UIViewController!
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        guard let view = loadView(nibName: "SideMenuView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    @IBAction func LogoutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "BurningUpSignInUp", bundle: nil)
        let pushController = storyboard.instantiateInitialViewController()
        
        pushController?.modalPresentationStyle = .fullScreen
        self.parentViewController.present(pushController!, animated: true, completion: nil)
        UserDefaults.standard.removeObject(forKey: "Email")
        UserDefaults.standard.removeObject(forKey: "Password")
        self.removeFromSuperview()
    }
}
