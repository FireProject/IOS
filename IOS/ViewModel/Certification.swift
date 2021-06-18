//
//  Certification.swift
//  IOS
//
//  Created by 장대호 on 2021/06/18.
//

import Foundation

class Certification {
    var postOwnerUid:String = ""
    var voteUids:[String:Int] = [:]
    var goodCount:Int {
        get {
            var goodCount = 0
            for tmp in voteUids {
                if tmp.value == 1 {
                    goodCount += 1
                }
            }
            return goodCount
        }
    }
    var badCount:Int {
        get {
            var badCount = 0
            for tmp in voteUids {
                if tmp.value != 0 {
                    badCount += 1
                }
            }
            return badCount
        }
    }
    init(data : [String:Any]) {
        self.postOwnerUid = data["uid"] as? String ?? ""
        self.voteUids = data["voteUsers"] as? [String:Int] ?? [:]
    }
}
