//
//  Friends.swift
//  IOS
//
//  Created by 장대호 on 2021/04/05.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

var friendsDatas: [BurningUpFriend] = []

class BurningUpFriend {
    var nickname:String = ""
    var stateMessage:String = ""
    var profileImage:UIImage = #imageLiteral(resourceName: "FriendsImage")
    var uid:String = ""
    init(friends :NSDictionary) {
        guard let nickname = friends["nickName"] as? String,
              let stateMessage = friends["stateMessage"] as? String
        else {
            return
        }
        self.nickname = nickname
        self.stateMessage = stateMessage

    }
}

func getFriends() {
    var ref: DatabaseReference!
    ref = Database.database().reference()
    let storage = Storage.storage()
    
    for friendUid in userData.friends {
        ref.child("users").child(friendUid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let friend = BurningUpFriend(friends: value ?? NSDictionary())
            // ...
            storage.reference(forURL: "gs://fire-71c1d.appspot.com/users/\(friendUid)/profileImage").downloadURL { (url, error) in
                if error != nil {
                    return
                }
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                friend.profileImage = image!
                friend.uid = friendUid
            }
            friendsDatas.append(friend)
        })  {(error) in
            print(error.localizedDescription)
        }
    }
}

func deleteFriendData(uid:String) {
    friendsDatas = friendsDatas.filter({
        if $0.uid != uid {
            return true
        } else {
            return false
        }
    })
    userData.friends = userData.friends.filter({
        if $0 != uid {
            return true
        } else {
            return false
        }
    })
    print(userData.friends)
    guard let uuid = Auth.auth().currentUser?.uid else {
        return
    }
    
    var ref: DatabaseReference!
    ref = Database.database().reference()
    ref.child("users/\(uuid)/friends").setValue(userData.friends)
}
