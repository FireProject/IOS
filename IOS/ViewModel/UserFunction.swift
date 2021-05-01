//
//  SignInClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

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
        let roomId = user["roomId"] as? [String] ?? []
        let stateMessage = user["stateMessage"] as? String ?? ""
        
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
    func getData(data: NSDictionary) {
        let friends = data["friends"] as? [String] ?? self.friends
        let nickname = data["nickName"] as? String ?? self.nickname
        let roomId = data["roomId"] as? [String] ?? self.roomId
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
    ref.child("users").child(user.uid).observe(.childAdded, with: { (snapshot) -> Void in
        let dic:NSDictionary = [snapshot.key:snapshot.value as Any]
        userData.getData(data: dic)
        if snapshot.key == "friends" {
            getFriends()
        }
        if snapshot.key == "roomId" {
            getRoomsData()
        }
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
