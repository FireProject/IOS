//
//  FriendsView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/17.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*
 * note : 본인보여주는 셀만 underLine이 있기를 원함
 */
class FriendsView: UIView,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var FriendsTableView: UITableView!
    
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
        
        
        guard let view = loadView(nibName: "FriendsView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        FriendsTableView.delegate = self
        FriendsTableView.dataSource = self
        FriendsTableView.backgroundColor = .black
        FriendsTableView.register(FriendsTabelHeader.self,
               forHeaderFooterViewReuseIdentifier: "userProfile")
        FriendsTableView.register(FriendsTableCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsDatas.count
    }
    
    //현재 수정중
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendsTableView.dequeueReusableCell(withIdentifier: "cell") as! FriendsTableCell
        cell.backgroundColor = .black
        cell.profileImage.image = friendsDatas[indexPath.row].profileImage
        cell.nickLabel.text = friendsDatas[indexPath.row].nickname
        cell.nickLabel.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:"userProfile") as! FriendsTabelHeader
        view.nickLabel.text = userData.nickname
        view.profileImage.image = userData.profileImage
        view.profileImage.clipsToBounds = true
        view.profileImage.layer.cornerRadius = 30
        return view
    }

    //친구 터치시 개인채팅 & 삭제버튼 보여줌
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("seleted!!")
    }
    
}
