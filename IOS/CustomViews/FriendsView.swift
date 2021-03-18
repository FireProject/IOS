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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let underLine = UIView()
        let profileImage = UIImageView()
        let nickLabel = UILabel()
        
        nickLabel.text = userData?.nickname
        nickLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nickLabel.textColor = .white
      
        
        profileImage.image = userData?.profileImage
        profileImage.contentMode = .scaleAspectFill
        
        underLine.backgroundColor = .white
        
        view.addSubview(underLine)
        view.addSubview(profileImage)
        view.addSubview(nickLabel)
        
        underLine.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nickLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            nickLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            underLine.heightAnchor.constraint(equalToConstant: 0.5),
            underLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            underLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            underLine.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }
    
}
