//
//  ChattingTopBar.swift
//  IOS
//
//  Created by 장대호 on 2021/03/19.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ChattingTopBar: UIView {
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
        guard let view = loadView(nibName: "ChattingTopBar") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    func setNavigationController(navigationController: BurningUpMainViewController) {
        self.navigationController = navigationController
    }
    @IBAction func makeRoomButtonAction(_ sender: Any) {
        let nextView = UIStoryboard(name: "BurningUpMain", bundle: nil).instantiateViewController(identifier: "PlusRoomViewController")
        
        self.navigationController.present(nextView, animated: true, completion: nil)
    }
}

