//
//  VoteViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/07.
//

import Foundation
import UIKit

class VoteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var certificationImage:[Certification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PostUserCertificationViewController") else {return}
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}

extension VoteViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    class Certification {
        var uidToImage:[String:UIImage] = [:]
        func setImage(user: String, image: UIImage){
            uidToImage[user] = image
        }
    }
    
    
    func getCertificationImage() {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! postCell
        cell.image.image = #imageLiteral(resourceName: "FriendsImage")
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
}


import Foundation
import UIKit
class postCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
