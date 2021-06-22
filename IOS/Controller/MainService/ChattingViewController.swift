//
//  ChattingViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/30.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ChattingViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    class MesageInfo {
        var message : String
        var uid : String
        init(uid:String, message:String) {
            self.message = message
            self.uid = uid
        }
    }
    
    @IBOutlet weak var messageTextFiled: UITextField!
    @IBOutlet weak var chattingCollectionView: UICollectionView!

    var messages:[MesageInfo] = []
    var profileImages:[String:UIImage] = [:]
    var userNickname:[String:String] = [:]
    //nickName,uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        chattingCollectionView.delegate = self
        chattingCollectionView.dataSource = self
        self.setting()
       

        chattingCollectionView.register(ChattingMessageCell.self, forCellWithReuseIdentifier: "messageCell")
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        chattingCollectionView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    @objc func endEdit() {
        self.view.endEditing(true)
        _ = self.view.subviews.map({
            if $0 is ChattingSideMenuView {
                $0.removeFromSuperview()
            }
        })
    }

    
    func setting() {
        guard let room = currentRoom else {
            return
        }
        let roomId = room.roomId
        let s = DispatchSemaphore(value: 0)
        for uid in room.userUid {
            Database.database().reference().child("users").child(uid).child("nickName").getData(completion: {(error, data) in
                guard let nickName = data.value as? String else {
                    return
                }
                self.userNickname[uid] = nickName

            })
            Storage.storage().reference(forURL: "gs://fire-71c1d.appspot.com/users/\(uid)/profileImage.png").downloadURL { (url, error) in
                if error != nil {
                    s.signal()
                    return
                }
                let data = NSData(contentsOf: url!)
                let image = UIImage(data: data! as Data)
                self.profileImages[uid] = image
                self.chattingCollectionView.reloadData()
            }
            
        }

        Database.database().reference().child("message").child("\(roomId)").observe(.childAdded, with: { (snapshot) in
            let dic = snapshot.value as? NSDictionary
            guard let message = dic?["sendText"] as? String ,
                  let uid = dic?["senderUid"] as? String else {
                return
            }
            self.messages.append(MesageInfo(uid: uid, message: message))
            self.chattingCollectionView.reloadData()
            
            let lastItemIndex = IndexPath(item: self.messages.count-1, section: 0)
            self.chattingCollectionView.scrollToItem(at: lastItemIndex, at: .top, animated: true)
        })
        
        // 유저 프로필 이미지 받아오기

        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        _ = self.view.subviews.map({
            if $0 is ChattingSideMenuView {
                $0.removeFromSuperview()
            }
        })
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 20)
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            
        }
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .gray
        let roomName = currentRoom?.roomName ?? "erorr Daeho"
        self.navigationItem.title = roomName
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        menuBtn.addTarget(self, action: #selector(chattingMenuAction), for: .touchUpInside)
        menuBtn.setBackgroundImage(#imageLiteral(resourceName: "SideMenuImage"), for: .normal)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc func chattingMenuAction(sender: UIButton!) {
        var alreadyHasSubView = false
        _ = self.view.subviews.map({
            if $0 is ChattingSideMenuView {
                $0.removeFromSuperview()
                alreadyHasSubView = true
            }
        })
        if alreadyHasSubView == true {
            return
        }
        
        let subView = ChattingSideMenuView()
        
        self.view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //subView.topAnchor.constraint(equalTo: self.chattingCollectionView.topAnchor),
            subView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.chattingCollectionView.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            subView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.65)
        ])
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        //디비에 보내기만 할까?
        guard let text = self.messageTextFiled.text ,
              let uid = Auth.auth().currentUser?.uid,
              let roomId = currentRoom?.roomId else {
            return
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        let comment = [
            "senderUid" : uid,
            "sendText" : text
        ]
        
        ref.child("message/\(roomId)").childByAutoId().setValue(comment)
        self.messageTextFiled.text = ""
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = self.chattingCollectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as! ChattingMessageCell
        cell.backgroundColor = .gray
        cell.messageLabel.text = "\(self.messages[indexPath.row].message)"

        
        if self.messages[indexPath.row].uid == Auth.auth().currentUser?.uid {
            cell.userProfileImage.image = nil
            cell.userNicknameLabel.text = nil
            cell.setMessageType(type: .user)
        } else if indexPath.row > 0 && self.messages[indexPath.row].uid == self.messages[indexPath.row-1].uid {
            cell.userProfileImage.image = nil
            cell.userNicknameLabel.text = nil
            cell.setMessageType(type: .otherUserNotProfile)
        } else {
            cell.userProfileImage.image = self.profileImages[self.messages[indexPath.row].uid] ?? #imageLiteral(resourceName: "FriendsImage")
            cell.userNicknameLabel.text = self.userNickname[self.messages[indexPath.row].uid] ?? "Nonamed"
            cell.setMessageType(type: .otherUser)
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        var size = screenSize.size
        
        size.height = 35
        if self.messages[indexPath.row].uid == Auth.auth().currentUser?.uid {
            size.height = 0
        } else if indexPath.row > 0 && self.messages[indexPath.row].uid == self.messages[indexPath.row-1].uid {
            size.height = 0
        }
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        label.text = self.messages[indexPath.row].message
        label.sizeToFit()
        
        let line = Int(label.frame.size.height/20)
        size.height += CGFloat(line) * 20
        return size
    }
    
    @IBAction func voteButtonAction(_ sender: Any) {
        guard let nvc = self.navigationController?.storyboard?.instantiateViewController(identifier: "voteViewController") else {return}
        self.navigationController?.pushViewController(nvc, animated: true)
    }
    
}
