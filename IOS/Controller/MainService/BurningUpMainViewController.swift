//
//  BurningUpMainViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
enum ViewEnum {
    case Friends
    case Home
    case Chatting
}
class BurningUpMainViewController : UIViewController {
    var sideMenuView: SideMenuView? = nil
    var viewMode:ViewEnum = .Home
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        sideMenuView?.removeFromSuperview()
        sideMenuView = nil
        self.view.endEditing(true)
    }


    @IBAction func LeftMenuButtonPressed(_ sender: Any) {
        if sideMenuView != nil {
            sideMenuView?.removeFromSuperview()
            sideMenuView = nil
            return
        }
        sideMenuView = SideMenuView()
        self.view.addSubview(sideMenuView!)
        sideMenuView?.translatesAutoresizingMaskIntoConstraints = false
        sideMenuView?.parentViewController = self
        self.view.addConstraint(NSLayoutConstraint(item: sideMenuView!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0))
        sideMenuView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        sideMenuView?.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0).isActive = true
        self.view.addConstraint(NSLayoutConstraint(item: sideMenuView!, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.6, constant: 0.0))
    }
    
    @IBAction func ChattingListViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Chatting{
            return
        }
    }
    @IBAction func HomeViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Home{
            return
        }
    }
    @IBAction func FriendsViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Friends{
            return
        }
    }
}
    
