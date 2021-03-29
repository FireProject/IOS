//
//  Rooms.swift
//  IOS
//
//  Created by 장대호 on 2021/03/26.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

var roomDatas:[ChattingRoomInfo] = []
//roomid
//name
//image
//curPerson / Maxperson
//background color
//voteCycle
//notice
//bannedUid
//usersUid
//Messages
//masterUid
class ChattingRoomInfo {
    var roomId:String = ""
    var backgroundColor:UIColor = .white
    var voteCycle:String = ""
    var notice:String = ""
    var bannedUid:[String] = []
    var userUid:[String] = []
    var messages:[String] = []
    var curPerson:Int = 2
    var maxPerson:Int = 2
    var image:UIImage = #imageLiteral(resourceName: "FriendsImage")
    var roomName:String = ""
    var masterUid:String = ""
    init(roomData: NSDictionary) {
        roomId = roomData["roomId"] as? String ?? ""
        notice = roomData["notice"] as? String ?? ""
        masterUid = roomData["masterUid"] as? String ?? ""
        bannedUid = roomData["bannedUid"] as? [String] ?? []
        userUid = roomData["users"] as? [String] ?? []
        maxPerson = roomData["maxPerson"] as? Int ?? 2
        curPerson = roomData["curPerson"] as? Int ?? 2
        roomName = roomData["roomName"] as? String ?? "NoNamed"
    }
}

func getRoomsData() {
    print(userData.roomId.count)
    for roomId in userData.roomId {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storage = Storage.storage()
        ref.child("rooms").child(roomId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            roomDatas.append(ChattingRoomInfo(roomData: value ?? NSDictionary()))
        })
    }
}
