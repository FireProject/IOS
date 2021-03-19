//
//  HomeTopBar.swift
//  IOS
//
//  Created by 장대호 on 2021/03/19.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class HomeTopBar: UIView {
    weak var parentView: UIView!
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
        guard let view = loadView(nibName: "HomeTopBar") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    func setParentView(view:UIView) {
        self.parentView = view
    }
}
