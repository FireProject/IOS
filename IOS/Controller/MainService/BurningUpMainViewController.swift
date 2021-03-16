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
class BurningUpMainViewController : UIViewController {

    @IBOutlet weak var roomSummaryView: UIView!
    var hasNickname = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavigationBarAndToolBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
    }
    func settingNavigationBarAndToolBar() {
        
    }

    @IBAction func LeftMenuButtonPressed(_ sender: Any) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 300)
        self.view.addSubview(SideMenuView(frame: frame))
    }
    
    @IBAction func LeftGestureAction(_ sender: UIGestureRecognizer) {
    }
    @IBAction func RightGestureAction(_ sender: UIGestureRecognizer) {
        
    }
}
    
