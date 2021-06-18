//
//  HomewView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/17.
//


import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class HomeView: UIView,RoomSummaryViewDelegate, MemoViewDelegate {
    @IBOutlet weak var roomSummaryView: RoomSummaryView!
    @IBOutlet weak var memoView: MemoView!
    var location = 0;
    
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
        guard let view = loadView(nibName: "HomeView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        roomSummaryView.delegate = self
        memoView.delegate = self
        roomSummaryView.setRoomSummary(loc: location)
        memoView.setText(text: "test")
    }
    
    func RoomSummaryViewSwipe(direction: UISwipeGestureRecognizer.Direction) {
        if direction == .left {
            location -= 1
            if location < 0 {
                location = roomDatas.count - 1
            }
        } else if direction == .right {
            location = (location + 1) % roomDatas.count
        } else {
            return
        }
        
        roomSummaryView.setRoomSummary(loc: location)
        memoView.setText(text: "test")
    }
    
    func MemoViewDidChange(_ textView: UITextView) {
        
    }
}

