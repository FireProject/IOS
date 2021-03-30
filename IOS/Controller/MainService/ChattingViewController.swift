//
//  ChattingViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/30.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class ChattingViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    
        self.navigationItem.title = "test 방"
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "SideMenuImage"), style: .plain, target: nil, action: nil)
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        //menuBtn.setImage(#imageLiteral(resourceName: "SideMenuImage"), for: .normal)
        menuBtn.setBackgroundImage(#imageLiteral(resourceName: "SideMenuImage"), for: .normal)


        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
        
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
