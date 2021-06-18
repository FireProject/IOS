//
//  FriendsTopBar.swift
//  IOS
//
//  Created by 장대호 on 2021/03/19.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class FriendsTopBar: UIView {
    weak var navigationController: BurningUpMainViewController!
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
        guard let view = loadView(nibName: "FriendsTopBar") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    func setNavigationController(navigationController: BurningUpMainViewController) {
        self.navigationController = navigationController
    }
    @IBAction func plusFriendsAction(_ sender: Any) {
        let nextView = UIStoryboard(name: "BurningUpMain", bundle: nil).instantiateViewController(identifier: "PlusFriendViewController")
        self.navigationController.present(nextView, animated: true, completion: nil)
    }
}


