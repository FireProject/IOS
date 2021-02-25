//
//  SignInSignOut.swift
//  IOS
//
//  Created by 장대호 on 2021/02/24.
//

import Foundation
import UIKit
import FirebaseAuth



func signUp(userEmail id:String, userPassword pw:String ) -> Bool {
    var isCreated = false
    Auth.auth().createUser(withEmail: id, password: pw) {
        authResult, error in
        if error != nil {
            return
        }
        if authResult != nil {
            isCreated = true
        }
    }
    UserDefaults.standard.setValue("email", forKey: id)
    UserDefaults.standard.setValue("password", forKey: pw)
    return isCreated
}
