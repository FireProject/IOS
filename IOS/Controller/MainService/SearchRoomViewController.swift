//
//  SearchRoomViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/31.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
class  SearchRoomViewController :UIViewController, UITableViewDelegate, UITableViewDataSource{
    var roomDatas:[ChattingRoomInfo] = []
    @IBOutlet weak var roomTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomTableView.delegate = self
        roomTableView.dataSource = self
        roomTableView.register(ChattingTableCell.classForCoder(), forCellReuseIdentifier: "chattingCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "채팅방 검색"
        self.setting()
    }
    func setting() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("rooms").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            guard let value = snapshot.value as? NSDictionary else {
                return
            }
            for room in value {
                guard let tmp = room.value as? NSDictionary else {
                    continue
                }
                
                guard let users = tmp["users"] as? [String] else {
                    continue
                }
                
                guard let userUid = Auth.auth().currentUser?.uid else {
                    continue
                }
                guard let roomId = room.key as? String else {
                    continue
                }
                if users.contains(userUid) {
                    continue
                }
                let data = ChattingRoomInfo(roomData:tmp)
                data.roomId = roomId
                self.roomDatas.append(data)
                self.roomTableView.reloadData()
            }
          }) { (error) in
            print(error.localizedDescription)
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomTableView.dequeueReusableCell(withIdentifier: "chattingCell") as! ChattingTableCell
        cell.backgroundColor = .black
        cell.profileImage.image = #imageLiteral(resourceName: "ChattingRoomImage")
        cell.roomName.text = self.roomDatas[indexPath.row].roomName
        cell.lastMessage.text = ""
        cell.roomName.textColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        guard let userUid = Auth.auth().currentUser?.uid else {
            return
        }
        let roomId = self.roomDatas[indexPath.row].roomId
        
        self.roomDatas[indexPath.row].userUid.append(userUid)
        let users = roomDatas[indexPath.row].userUid
        ref.child("rooms").child("\(roomId)").child("users").setValue(users)
        userData.roomId.append(roomId)
        ref.child("users").child("\(userUid)").child("roomIds").setValue(userData.roomId)
        self.roomDatas.remove(at: indexPath.row)
        self.roomTableView.reloadData()
        
    }
}
