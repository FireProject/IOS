//
//  Rooms.swift
//  IOS
//
//  Created by 장대호 on 2021/03/26.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
var currentRoom:ChattingRoomInfo? = nil
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
        backgroundColor = HexStringToUIColor(hexColor: roomData["backgroundColor"] as? String ?? "0xFFFFFF")
    }
}


func getRoomsData() {
    var ref: DatabaseReference!
    ref = Database.database().reference()
    let storage = Storage.storage()
    for roomId in userData.roomId {
        
        ref.child("rooms").child(roomId).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let tmp = ChattingRoomInfo(roomData: value ?? NSDictionary())
            tmp.roomId = roomId
            
            storage.reference(forURL: "gs://fire-71c1d.appspot.com/rooms/\(roomId)/profileImage").downloadURL { (url, error) in
                if error != nil {
                    return
                }
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                tmp.image = image!
                roomDatas.append(tmp)
            }
        })
    }
}

func plusRoomData(id:String) {
    var ref: DatabaseReference!
    ref = Database.database().reference()
    let storage = Storage.storage()
    ref.child("rooms").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let tmp = ChattingRoomInfo(roomData: value ?? NSDictionary())
        tmp.roomId = id
        
        storage.reference(forURL: "gs://fire-71c1d.appspot.com/rooms/\(id)/profileImage").downloadURL { (url, error) in
            if error != nil {
                return
            }
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            tmp.image = image!
        }
        roomDatas.append(tmp)
    })
}

//Debug Function
func CheckRoomDatas() {
    for i in 0..<roomDatas.count {
        let room = roomDatas[i]
        print("roomName :\(room.roomName)")
        print("roomID :\(room.roomId)")
    }
}
