//
//  FriendsView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/17.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*
 * note : 본인보여주는 셀만 underLine이 있기를 원함
 */
class FriendsView: UIView,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var FriendsTableView: UITableView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        
        
        guard let view = loadView(nibName: "FriendsView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        FriendsTableView.delegate = self
        FriendsTableView.dataSource = self
        FriendsTableView.backgroundColor = .black
        FriendsTableView.register(MyCustomHeader.self,
               forHeaderFooterViewReuseIdentifier: "userProfile")
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:"userProfile") as! MyCustomHeader
        view.nickLabel.text = userData.nickname
        view.profileImage.image = userData.profileImage
        view.profileImage.clipsToBounds = true
        view.profileImage.layer.cornerRadius = 25
        return view
    }
    
}
