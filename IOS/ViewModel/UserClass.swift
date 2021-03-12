//
//  SignInClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
var userData:UserData? = nil
class UserData {
    private var image:UIImage?
    private var nickname:String
    init(nickname:String,image:UIImage? = nil) {
        self.nickname = nickname
        self.image = image
    }
}

