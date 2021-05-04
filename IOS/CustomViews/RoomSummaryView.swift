//
//  RoomSummaryView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/15.
//

import Foundation
import UIKit


class RoomSummaryView: UIView {
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomProfileImage: UIImageView!
    @IBOutlet weak var remainVoteTimeLabel: UILabel!
    weak var delegate:RoomSummaryViewDelegate?
    
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
        roomProfileImage.layer.masksToBounds = true
        roomProfileImage.layer.cornerRadius = roomProfileImage.frame.width/3.35
        roomProfileImage.contentMode = .scaleAspectFill
    }

    @IBAction func SwipeAction(_ sender: UISwipeGestureRecognizer) {
        delegate?.RoomSummaryViewSwipe(direction: sender.direction)
    }
    
    func setRoomSummary(loc:Int) {
        if roomDatas.count <= loc || loc < 0{
            return
        }
        let room = roomDatas[loc]
        self.roomNameLabel.text = room.roomName
        self.roomProfileImage.image = room.image
        
    }
}

protocol RoomSummaryViewDelegate: AnyObject {
    func RoomSummaryViewSwipe(direction:UISwipeGestureRecognizer.Direction)
}

