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
var friendsData: [BurningUpFriend] = []

class BurningUpUser {
    var friends:[String] = []
    var nickname:String = ""
    var roomId:[String] = []
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    init(user: NSDictionary) {
        
        let friends = user["friends"] as? [String] ?? []
        let nickname = user["nickname"] as? String ?? "NoNamed"
        let roomId = user["roomId"] as? [String] ?? []
        let stateMessage = user["stateMessage"] as? String ?? ""
        
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
}



class BurningUpFriend {
    var nickname:String = ""
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    init(friends :NSDictionary) {
        guard let nickname = friends["nickname"] as? String,
              let stateMessage = friends["stateMessage"] as? String else {
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
        let value = snapshot.value as? NSDictionary
        userData = BurningUpUser(user: value ?? NSDictionary())
        storage.reference(forURL: "gs://fire-71c1d.appspot.com/\(user.uid)").downloadURL { (url, error) in
            if error != nil {
                return
            }
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            userData.profileImage = image!
        }

        for friendUid in userData.friends {
            ref.child("users").child(friendUid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                
                let friend = BurningUpFriend(friends: value ?? NSDictionary())
                // ...
                storage.reference(forURL: "gs://fire-71c1d.appspot.com/\(friendUid)").downloadURL { (url, error) in
                    if error != nil {
                        return
                    }
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                    friend.profileImage = image!
                }
                friendsData.append(friend)
            })  {(error) in
                print(error.localizedDescription)
            }
        }
    })
}
