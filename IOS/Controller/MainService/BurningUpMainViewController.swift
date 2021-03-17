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
        self.viewMode = .Home
        self.setHomeView()
    }
    
    //뷰 터치시 메뉴뷰 사라지게끔
    //문제점 : 메뉴뷰 눌러도 사라지는건 좀...?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        sideMenuView?.removeFromSuperview()
        sideMenuView = nil
        self.view.endEditing(true)
    }

    //toolbar 왼쪽상단 버튼
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
    
    
    //tabBar Button Actions
    @IBAction func ChattingListViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Chatting{
            return
        }
        self.viewMode = .Chatting
        self.removeAllSubViews()
    }
    @IBAction func HomeViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Home{
            return
        }
        self.viewMode = .Home
        self.removeAllSubViews()
        self.setHomeView()
        
    }
    @IBAction func FriendsViewButtonPressed(_ sender: Any) {
        if self.viewMode == .Friends{
            return
        }
        self.viewMode = .Friends
        self.removeAllSubViews()
    }
    
    func removeAllSubViews() {
        let _ = self.view.subviews.map({$0.removeFromSuperview()})
    }
    
    //view Chage Func
    func setHomeView() {
        let homeView = HomeView()
        self.view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
}
    
