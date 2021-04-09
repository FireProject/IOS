//
//  VoteViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/07.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class VoteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var certificationData:Certifications = Certifications()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getCertifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.barTintColor = UIColor.systemPink
        let roomName = "투표하기"
        self.navigationItem.title = roomName
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        menuBtn.setBackgroundImage(#imageLiteral(resourceName: "SideMenuImage"), for: .normal)
        menuBtn.target(forAction: #selector(plusCertificationAction(_:)), withSender: nil)
        menuBtn.addTarget(self, action: #selector(plusCertificationAction(_:)), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 25)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 25)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc func plusCertificationAction(_ sender : Any?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        if certificationData.isUserContains(user: uid) == true {
            let alert = UIAlertController(title: "에러", message: "이미 인증하셨습니다. 본인 사진을 눌러 수정이 가능합니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PostUserCertificationViewController") else {return}
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}

extension VoteViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    class Certification {
        var uid:String
        var image:UIImage
        var message:String
        init(uid:String, image:UIImage, message:String) {
            self.uid = uid
            self.image = image
            self.message = message
        }
    }
    class Certifications {
        var certifications:[Certification] = []
        var count:Int {
            certifications.count
        }
        
        func pushData(data:Certification) {
            certifications.append(data)
        }
        
        func isUserContains(user:String) -> Bool{
            for certification in certifications {
                if certification.uid == user {
                    return true
                }
            }
            return false;
        }
        func setImage(user:String,image:UIImage) {
            if isUserContains(user: user) == false {
                pushData(data: Certification(uid: user, image: image, message: ""))
            }
            for i in 0..<certifications.count {
                if certifications[i].uid == user {
                    certifications[i].image = image
                    break
                }
            }
        }
        func setMessage(user:String,message:String) {
            if isUserContains(user: user) == false {
                pushData(data: Certification(uid: user, image: #imageLiteral(resourceName: "FriendsImage"), message: message))
            }
            for i in 0..<certifications.count {
                if certifications[i].uid == user {
                    certifications[i].message = message
                    break
                }
            }
        }
        func getImage(at:Int) -> UIImage {
            return certifications[at].image
        }
        func getMessage(at:Int) -> String {
            return certifications[at].message
        }
        func getInfo(at:Int) -> Certification{
            return certifications[at]
        }
    }
    
    func getCertifications() {
        guard let currentRoom = currentRoom else {return}
        for userUid in currentRoom.userUid {
            if certificationData.isUserContains(user: userUid) == false {
                getCertification(uid: userUid)
            }
        }
        
    }
    
    func getCertification(uid:String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storage = Storage.storage(url: "gs://fire-71c1d.appspot.com/")
        guard let currentRoom = currentRoom else {
            return
        }
        
        let tmpDate = DateFormatter()
        tmpDate.dateFormat = "YYYYMMdd"
        let date = tmpDate.string(from: Date())
        
        
        ref.child("certification").child(currentRoom.roomId).child(date).child(uid).child("message").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            guard let value = snapshot.value as? String else {return}
            
            self.certificationData.setMessage(user: uid, message: value)
            self.collectionView.reloadData()
        })  {(error) in
            print(error.localizedDescription)
        }
        storage.reference(forURL: "gs://fire-71c1d.appspot.com/rooms/\(currentRoom.roomId)/\(date)/\(uid)/postImage").downloadURL { (url, error) in
            if error != nil {
                return
            }
            
            let data = NSData(contentsOf: url!)
            guard let image = UIImage(data: data! as Data) else {return}
            
            self.certificationData.setImage(user: uid, image: image)
            self.collectionView.reloadData()
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return 1
        return certificationData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! postCell
        //cell.image.image = #imageLiteral(resourceName: "FireImage")
        cell.image.image = certificationData.getImage(at:indexPath.section*3 + indexPath.row)
        
        cell.image.contentMode = .scaleAspectFill
        cell.backgroundColor = .green
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        var size = screenSize.size
        size.width = size.width/3 - 2
        size.height = size.width
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let n = indexPath.section * 3 + indexPath.row
        let info = certificationData.getInfo(at: n)
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "VotePostViewController") else {return}
        guard let vc = nextVC as? VotePostViewController else {return}
        vc.setUserInfo(info: info)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}


import Foundation
import UIKit
class postCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    func setting() {
        
    }
}
