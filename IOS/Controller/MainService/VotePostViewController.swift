//
//  VotePostViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/09.
//

import Foundation
import UIKit
import Firebase

//
class VotePostViewController:UIViewController {
    var userInfo:VoteViewController.Certification? = nil

    @IBOutlet weak var MemoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    let textView = UnderlinedTextView()
    
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    var certification:Certification? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewSetting()
        textView.text = userInfo?.message
        imageView.image = userInfo?.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func setData() {
        guard let postOwnerUid = userInfo?.uid else {
            return
        }
        guard let roomId = currentRoom?.roomId else {
            return
        }

        
        let tmpDate = DateFormatter()
        tmpDate.dateFormat = "YYYYMMdd"
        let date = tmpDate.string(from: Date())
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("\(roomId)/\(date)/\(postOwnerUid)").observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard var data = snapshot.value as? [String:Any] else{
                return
            }
            data["uid"] = postOwnerUid
            self.certification = Certification(data: data)
        })
        
    }
    func textViewSetting() {
        self.textView.autocorrectionType = .no
        self.textView.autocapitalizationType = .none
        self.textView.smartQuotesType = .no
        self.textView.textContentType = .none
        self.textView.spellCheckingType = .no
        self.textView.smartInsertDeleteType = .no
        self.textView.smartDashesType = .no
        self.textView.isEditable = false
        
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 35)
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.MemoView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: MemoView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: MemoView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: MemoView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: MemoView.bottomAnchor),
        ])
    }
    func setUserInfo(info:VoteViewController.Certification) {
        self.userInfo = info
        if userInfo?.uid == Auth.auth().currentUser?.uid {
            self.badButton.isEnabled = false
            self.goodButton.isEnabled = false
        }
        setData()
    }
    @IBAction func exitButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func badButtonAction(_ sender: Any) {
        guard var certi = self.certification else {
            return
        }
        
    }
    
    @IBAction func goodButtonAction(_ sender: Any) {
        guard var certi = self.certification else {
            return
        }
    }
}
