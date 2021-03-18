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

class BuningUpUser {
    var friends:[String] = []
    var nickname:String = ""
    var roomId:[String] = []
    var stateMessage:String = ""
    init(user: NSDictionary) {
        guard let friends = user["friends"] as? [String],
              let nickname = user["nickname"] as? String,
              let roomId = user["roomId"] as? [String],
              let stateMessage = user["statMessage"] as? String else {
            return
        }
        self.friends = friends
        self.nickname = nickname
        self.roomId = roomId
        self.stateMessage = stateMessage
    }
}
