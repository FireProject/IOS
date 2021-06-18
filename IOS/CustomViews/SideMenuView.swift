//
//  SideMenuView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/16.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SideMenuView: UIView {
    weak var parentViewController: UIViewController!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNickNameLabel: UILabel!
    
    
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
        userProfileImage.image = userData.profileImage
        userProfileImage.contentMode = .scaleAspectFill
        userProfileImage.layer.masksToBounds = true
        userProfileImage.layer.cornerRadius = self.userProfileImage.frame.width/1.5
        
       
        userNickNameLabel.text = "\(userData.nickname)님 환영합니다!"
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
        resetAllData()
        self.removeFromSuperview()
    }
    @IBAction func profileModifyAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "BurningUpSignInUp", bundle: nil)
        let nextView = storyboard.instantiateViewController(identifier: "SignInImageNickname")
        self.parentViewController.navigationController?.navigationBar.isHidden = false
        self.parentViewController.navigationController?.pushViewController(nextView, animated: true)
    }
    @IBAction func resetPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "BurningUpSignInUp", bundle: nil)
        let nextView = storyboard.instantiateViewController(identifier: "ResetPasswordViewController")
        
        self.parentViewController.navigationController?.pushViewController(nextView, animated: true)
    }
    @IBAction func introduceUsAction(_ sender: Any) {
        //개발자 소개 뷰와 연결
    }
}
