//
//  ChattingViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/30.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class ChattingViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var messageTextFiled: UITextField!
    @IBOutlet weak var chattingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.setting()
    }
    
    func setting() {
        Database.database().reference().child("Messages").observe(DataEventType.value, with: { (datasnapshot) in
            
        })
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 20
                )
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationItem.title = "test 방"
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        //menuBtn.setImage(#imageLiteral(resourceName: "SideMenuImage"), for: .normal)
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
            "uid" : uid,
            "Message" : text
        ]
        
        ref.child("Messages/\(roomId)").childByAutoId().setValue(comment)
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.backgroundColor = .gray
        return cell
    }
    
    
}
