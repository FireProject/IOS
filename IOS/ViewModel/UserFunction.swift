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

var userData: BurningUpUser? = nil

class BurningUpUser {
    var friends:[String] = []
    var nickname:String = ""
    var roomId:[String] = []
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    init(user: NSDictionary) {
        
        guard let friends = user["friends"] as? [String],
              let nickname = user["nikname"] as? String,
              let roomId = user["roomId"] as? [String],
              let stateMessage = user["stateMessage"] as? String else {
            
            return
        }
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
}

class BurningUpFriends {
    var nickname:String = ""
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    init(friends :NSDictionary) {
        guard let nickname = friends["nickname"] as? String,
              let stateMessage = friends["statMessage"] as? String else {
            return
        }
        self.nickname = nickname
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
    let storage = Storage.storage()
    
    ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
      // Get user value
        guard let value = snapshot.value as? NSDictionary else {
            return
        }
        
        userData = BurningUpUser(user: value)
        storage.reference(forURL: "gs://fire-71c1d.appspot.com/\(user.uid)").downloadURL { (url, error) in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            userData?.profileImage = image!
        }
        
      }) { (error) in
        
        print(error.localizedDescription)
    }
}
