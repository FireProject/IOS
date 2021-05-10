//
//  ChattingSideMenuView.swift
//  IOS
//
//  Created by 장대호 on 2021/05/06.
//

import Foundation
import UIKit
import FirebaseAuth
class ChattingSideMenuView: UIView,UITableViewDelegate, UITableViewDataSource {

    
    let logoImageView = UIImageView()
    let roomImageView = UIImageView()
    let roomNameLabel = UILabel()
    var tableView = UITableView()
    let tableViewText = ["●  채팅방 설정" ,"●  공지사항"]
    let exitButton = UIButton()
    let roomView =  roomInfoView()
    
    weak var delegate:ChattingSideMenuViewDelegate?
    weak var dataSource:ChattingSideMenuViewDataSource?
    
    var roomInfo:ChattingRoomInfo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    func loadView() {
        self.backgroundColor = .white
        guard let room = currentRoom else {
            return
        }
        guard let userUid = Auth.auth().currentUser?.uid else {
            return
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        logoImageView.image = #imageLiteral(resourceName: "MainLogo")
        roomImageView.image = room.image
        roomImageView.layer.masksToBounds = true
        roomImageView.layer.cornerRadius = 63.5
        roomNameLabel.text = room.roomName
        roomNameLabel.textAlignment = .center
        roomNameLabel.textColor = .black
        exitButton.addTarget(self, action: #selector(self.extiButtonAction), for: .touchUpInside)
        exitButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
        exitButton.contentMode = .scaleAspectFill
        exitButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        exitButton.setTitle("방장 위임하기", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)
        exitButton.setTitleColor(.gray, for: .highlighted)
        exitButton.semanticContentAttribute = .forceLeftToRight
        
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        roomImageView.translatesAutoresizingMaskIntoConstraints = false
        roomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(logoImageView)
        self.addSubview(roomImageView)
        self.addSubview(roomNameLabel)
        self.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.7),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            
            roomImageView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor),
            roomImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            roomImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5),
            roomImageView.heightAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5),
            
            roomNameLabel.topAnchor.constraint(equalTo: roomImageView.bottomAnchor),
            roomNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            roomNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            roomNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            
            exitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            exitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            exitButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            exitButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05)
        ])
        
        if room.masterUid == userUid {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            roomView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tableView)
            self.addSubview(roomView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: roomNameLabel.bottomAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.13),
                
                roomView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
                roomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                roomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                roomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.27),
            ])
        } else {
            self.addSubview(roomView)
            roomView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                roomView.topAnchor.constraint(equalTo: roomNameLabel.bottomAnchor),
                roomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                roomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                roomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.27),
            ])
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tableViewText[indexPath.row]
        return cell
    }
    @objc func extiButtonAction() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        self.delegate?.exitButtonPressed(uid: uid)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let master = self.roomInfo?.masterUid,
              let user = Auth.auth().currentUser?.uid
              else {
            return
        }
        if master != user {
            return
        }
        
        
        let row = indexPath.row
        switch row {
        case 0:
            //채팅방 설정
            break
        case 1:
            //공지 설정
            break
        default:
            break
        }
    }
}

protocol ChattingSideMenuViewDataSource : AnyObject{
    func ChattingSideMenuViewRoomData() -> ChattingRoomInfo
}


protocol ChattingSideMenuViewDelegate : AnyObject{
    func exitButtonPressed(uid:String)
}
class roomInfoView: UIView {
    let roomNameLabel = UILabel()
    let roomPeopleLabel = UILabel()
    let voteTimeLabel = UILabel()
    let userScoreLabel = UILabel()
    var roomInfo: ChattingRoomInfo?
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    func loadView() {
        reloadData()
        self.backgroundColor = .gray
        roomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        roomPeopleLabel.translatesAutoresizingMaskIntoConstraints = false
        voteTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(roomNameLabel)
        self.addSubview(roomPeopleLabel)
        self.addSubview(voteTimeLabel)
        self.addSubview(userScoreLabel)
        
        NSLayoutConstraint.activate([
            roomNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            roomNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            roomNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            roomNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.3),
            
            roomPeopleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            roomPeopleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            roomPeopleLabel.topAnchor.constraint(equalTo: roomNameLabel.bottomAnchor),
            roomPeopleLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.23),
            
            voteTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            voteTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            voteTimeLabel.topAnchor.constraint(equalTo: roomPeopleLabel.bottomAnchor),
            voteTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.23),
            
            userScoreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            userScoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userScoreLabel.topAnchor.constraint(equalTo: voteTimeLabel.bottomAnchor),
            userScoreLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.23),
        ])
    }
    
    func reloadData() {
        roomInfo = currentRoom
        guard let room = roomInfo else {
            return
        }
        guard let userUid = Auth.auth().currentUser?.uid else {
            return
        }
        if room.masterUid == userUid {
            roomNameLabel.text = " \(room.roomName)"
        } else {
            roomNameLabel.text = " \(room.roomName) (방장 이미지)"
        }
        roomPeopleLabel.text = " 채팅방 인원 (\(room.curPerson)/\(room.maxPerson))"
        voteTimeLabel.text = " 투표시간 : 매일 1시"
        userScoreLabel.text = " 내 점수"
    }
}
