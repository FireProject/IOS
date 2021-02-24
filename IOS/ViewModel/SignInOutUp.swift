//
//  SignInSignOut.swift
//  IOS
//
//  Created by 장대호 on 2021/02/24.
//

import Foundation
import UIKit
import FirebaseAuth

func signIn(userEmail id:String, userPassword pw:String ) -> Bool {
    let semaphore = DispatchSemaphore(value: 0)
    var isLogined = false
    
    
    Auth.auth().signIn(withEmail: id, password: pw) {_,_ in
        print("hi")
    }
    
    if let user = Auth.auth().currentUser {
        UserDefaults.standard.set(id, forKey: "email")
        UserDefaults.standard.set(pw, forKey: "password")
        isLogined = true
    }
    
    return isLogined
}

func signOut() {
    let firebaseAuth = Auth.auth()
    do {
        try firebaseAuth.signOut()
    } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
    }
}

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
