//
//  ChattingView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/19.
//


import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*
 * note : 본인보여주는 셀만 underLine이 있기를 원함
 */
class ChattingView: UIView,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var chattingTable: UITableView!
    
    
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
        guard let view = loadView(nibName: "ChattingView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        self.chattingTable.delegate = self
        self.chattingTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chattingTable.dequeueReusableCell(withIdentifier: "cell") as! FriendsTableCell
        cell.backgroundColor = .black
        cell.profileImage.image = friendsData[indexPath.row].profileImage
        cell.nickLabel.text = friendsData[indexPath.row].nickname
        cell.nickLabel.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
