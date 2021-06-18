//
//  SignInClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

var userData: BurningUpUser = BurningUpUser(user: NSDictionary())


class BurningUpUser {
    var friends:[String] = []
    var nickname:String = ""
    var roomId:[String] = []
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    init(user: NSDictionary) {
        let friends = user["friends"] as? [String] ?? []
        let nickname = user["nickName"] as? String ?? "NoNamed"
        let roomId = user["roomIds"] as? [String] ?? []
        let stateMessage = user["stateMessage"] as? String ?? ""
        
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
    func getData(data: NSDictionary) {
        let friends = data["friends"] as? [String] ?? self.friends
        let nickname = data["nickName"] as? String ?? self.nickname
        let roomId = data["roomIds"] as? [String] ?? self.roomId
        let stateMessage = data["stateMessage"] as? String ?? self.stateMessage
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
}





func userSetting() {
    getUserData()
    
}

func resetAllData(){
    userData = BurningUpUser(user: NSDictionary())
    currentRoom = nil
    roomDatas = []
    friendsDatas = []
}

func getUserData() {
    guard let user = Auth.auth().currentUser else {
        return
    }
    
    var ref: DatabaseReference!
    ref = Database.database().reference()
    
    //만약 저장 안되어있으면 다시 디비에 저장
    if let email = user.email?.data(using: .utf8)!.map({String(format:"%02x", $0)}).joined()  {
        ref.child("emailToUid/\(String(describing: email))").setValue(user.uid)
    }
    
    //유저 정보 변경 대기

    ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let dic:NSDictionary = snapshot.value as! NSDictionary
        userData.getData(data: dic)
        // ...
    }) { (error) in
        print(error.localizedDescription)
    }
    
    
    //친구 추가시
    ref.child("users").child(user.uid).child("friends").observe(.childAdded, with: { (snapshot) -> Void in
        guard let uid = snapshot.value as? String else {
            print("error")
            return
        }
        plusFriendData(uid: uid)
    })
    
    //친구 삭제시 이벤트
    ref.child("users").child(user.uid).child("friends").observe(.childRemoved, with: { (snapshot) -> Void in
        //not yet..
    })
    
    //방 추가시
    ref.child("users").child(user.uid).child("roomIds").observe(.childAdded, with: { (snapshot) -> Void in
        guard let roomId = snapshot.value as? String else {
            print("error")
            return
        }
        
        plusRoomData(id: roomId)
    })
    
    //방 삭제시 이벤트
    ref.child("users").child(user.uid).child("roomIds").observe(.childRemoved, with: { (snapshot) -> Void in
        //not yet
    })
    
    
    getUserProfileImage(uid: user.uid)
  
}

func getUserProfileImage(uid:String) {
    let storage = Storage.storage()
    storage.reference(forURL: "gs://fire-71c1d.appspot.com/users/\(uid)/profileImage").downloadURL { (url, error) in
        if error != nil {
            return
        }
        let data = NSData(contentsOf: url!)
        let image = UIImage(data: data! as Data)
        userData.profileImage = image!
    }
}
