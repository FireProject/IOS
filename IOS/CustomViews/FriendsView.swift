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
    var subView = FriendSubView()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendsTableView.dequeueReusableCell(withIdentifier: "cell") as! FriendsTableCell
        cell.backgroundColor = .black
        cell.profileImage.image = friendsDatas[indexPath.row].profileImage
        cell.nickLabel.text = friendsDatas[indexPath.row].nickname
        cell.stateMessageLabel.text = friendsDatas[indexPath.row].stateMessage
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
        subView.friendUid = friendsDatas[indexPath.row].uid
        subView.profileImage.image = friendsDatas[indexPath.row].profileImage
        subView.nickNameLabel.text = friendsDatas[indexPath.row].nickname
        subView.stateMessageLabel.text = friendsDatas[indexPath.row].stateMessage
        self.addSubview(subView)
        setLayoutOfSubView()
    }
    
    func setLayoutOfSubView() {
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.widthAnchor.constraint(equalTo: self.widthAnchor),
            subView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

class FriendSubView:UIView {
    let exitButton = UIButton()
    let profileImage = UIImageView()
    let nickNameLabel = UILabel()
    let stateMessageLabel = UILabel()
    let chattingButton = UIButton()
    let deleteFriendButton = UIButton()
    var friendUid = ""
    weak var delegate:FriendSubViewDelegate?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.7399609685, green: 0.8449184299, blue: 0.9341754913, alpha: 1)
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        
        profileImage.image = #imageLiteral(resourceName: "FriendsImage")
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 40
        
        nickNameLabel.text = "NoNamed"
        
        stateMessageLabel.text = "상태매세지 테스트중입니다 얼마나 길게까지 될지 함 봐보십시요용요요요용ㅇ"
        stateMessageLabel.layer.masksToBounds = true
        stateMessageLabel.layer.cornerRadius = 10
        stateMessageLabel.layer.borderWidth = 1.5
        stateMessageLabel.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stateMessageLabel.textColor = .black
        stateMessageLabel.numberOfLines = 2
        stateMessageLabel.textAlignment = .center
        
        chattingButton.setBackgroundImage(#imageLiteral(resourceName: "ChattingRoomImage"), for: .normal)
        
        deleteFriendButton.setBackgroundImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
        deleteFriendButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        self.addSubview(exitButton)
        self.addSubview(profileImage)
        self.addSubview(nickNameLabel)
        self.addSubview(stateMessageLabel)
        self.addSubview(chattingButton)
        self.addSubview(deleteFriendButton)
        
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stateMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        chattingButton.translatesAutoresizingMaskIntoConstraints = false
        deleteFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            exitButton.topAnchor.constraint(equalTo: self.topAnchor),
            exitButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.175),
            exitButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            
            nickNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            nickNameLabel.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor),
            nickNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            nickNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stateMessageLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            stateMessageLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor),
            stateMessageLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            stateMessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            chattingButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            chattingButton.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: -70),
            chattingButton.widthAnchor.constraint(equalToConstant: 50),
            chattingButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteFriendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            deleteFriendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: 70),
            deleteFriendButton.widthAnchor.constraint(equalToConstant: 50),
            deleteFriendButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func exitButtonAction() {
        self.removeFromSuperview()
    }
    //여기 하는중
    @objc func deleteButtonAction() {
        //삭제, 디비 업데이트
        delegate?.deleteFriend(uid:friendUid)
    }
}


protocol FriendSubViewDelegate: AnyObject {
    func deleteFriend(uid:String)
}
