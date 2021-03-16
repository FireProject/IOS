//
//  RoomSummaryView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/15.
//

import Foundation
import UIKit


class RoomSummaryView: UIView {
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
        guard let view = loadView(nibName: "RoomSummaryView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}