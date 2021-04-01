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
        
    }
    
    //뷰 터치시 메뉴뷰 사라지게끔
    //문제점 : 메뉴뷰 눌러도 사라지는건 좀...?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        sideMenuView?.removeFromSuperview()
        sideMenuView = nil
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isToolbarHidden = false
        switch viewMode {
        case .Chatting:
            setChattingView()
            break
        case .Friends:
            setFriendsView()
            break
        case .Home:
            setHomeView()
            break
        }
    }
    
    //toolbar 왼쪽상단 버튼
    func LeftMenuButtonPressed() {
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
        sideMenuView = nil
        self.viewMode = .Chatting
        self.removeAllSubViews()
        self.setChattingView()
        
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
        self.setFriendsView()
        self.navigationController?.toolbar.largeContentImage = nil
    }
    
    func removeAllSubViews() {
        sideMenuView = nil
        let _ = self.view.subviews.map({$0.removeFromSuperview()})
    }
    
    //view Chage Func
    func setFriendsView() {
        let topBar = FriendsTopBar()
        let friendsView = FriendsView()
        
        topBar.setNavigationController(navigationController: self)
        
        self.view.addSubview(topBar)
        self.view.addSubview(friendsView)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        friendsView.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.1).isActive = true
        
        friendsView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        friendsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        friendsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        friendsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    func setChattingView() {
        let topBar = ChattingTopBar()
        let chattingView = ChattingView()
        
        chattingView.setNavigation(navigation: self)
        topBar.setNavigationController(navigationController : self)
        
        
        self.view.addSubview(topBar)
        self.view.addSubview(chattingView)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        chattingView.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.1).isActive = true
        
        chattingView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        chattingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chattingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        chattingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setHomeView() {
        
        let topBar = HomeTopBar()
        let homeView = HomeView()
        topBar.setParentViewContoller(viewController: self)
        
        self.view.addSubview(topBar)
        self.view.addSubview(homeView)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 0.1).isActive = true
        
        homeView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
    
