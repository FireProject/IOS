//
//  ChattingSideMenuView.swift
//  IOS
//
//  Created by 장대호 on 2021/05/06.
//

import Foundation
import UIKit
class ChattingSideMenuView: UIView {
    let logoImageView = UIImageView()
    let roomImageView = UIImageView()
    let roomNameLabel = UILabel()
    var tableView :UITableView?
    
    weak var delegate:ChattingSideMenuViewDelegate?
    weak var dataSource:ChattingSideMenuViewDataSource?
    
    var roomInfo:ChattingRoomInfo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        
    }
    init(frame: CGRect, roomInfo:ChattingRoomInfo) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        
    }
 
}

protocol ChattingSideMenuViewDataSource : AnyObject{
    func ChattingSideMenuViewRoomData() -> ChattingRoomInfo
}


protocol ChattingSideMenuViewDelegate : AnyObject{
    func exitButtonPressed(masterUid:String)
}
