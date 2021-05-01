//
//  FriendsViewTableClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/21.
//

import Foundation
import UIKit
class FriendsTabelHeader: UITableViewHeaderFooterView {
    let underLine = UIView()
    let profileImage = UIImageView()
    let nickLabel = UILabel()
    
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        self.contentView.backgroundColor = .black
        nickLabel.text = userData.nickname
        nickLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nickLabel.textColor = .white
      
        
        profileImage.image = userData.profileImage
        profileImage.contentMode = .scaleAspectFill
        
        underLine.backgroundColor = .white
        underLine.alpha = 0.5
        
        contentView.addSubview(underLine)
        contentView.addSubview(profileImage)
        contentView.addSubview(nickLabel)
        
        underLine.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            
            nickLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            nickLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            underLine.heightAnchor.constraint(equalToConstant: 0.5),
            underLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            underLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            underLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}


class FriendsTableCell: UITableViewCell {
    let profileImage = UIImageView()
    let nickLabel = UILabel()
    let stateMessageLabel = UILabel()
    let levelImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setting()
    }
    
    func setting() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .black
        
        nickLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nickLabel.textColor = .white
        stateMessageLabel.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.9960784314, blue: 0.9882352941, alpha: 1)
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 30
        
        levelImage.contentMode = .scaleAspectFill
        levelImage.layer.masksToBounds = true
        levelImage.layer.cornerRadius = 15
        levelImage.image = #imageLiteral(resourceName: "FireImage")
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nickLabel)
        contentView.addSubview(levelImage)
        contentView.addSubview(stateMessageLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickLabel.translatesAutoresizingMaskIntoConstraints = false
        levelImage.translatesAutoresizingMaskIntoConstraints = false
        stateMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            
            nickLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            nickLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            nickLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            stateMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 10),
            
            levelImage.widthAnchor.constraint(equalToConstant: 30),
            levelImage.heightAnchor.constraint(equalToConstant: 30),
            levelImage.leadingAnchor.constraint(equalTo: nickLabel.trailingAnchor, constant: 5),
            levelImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            stateMessageLabel.leadingAnchor.constraint(lessThanOrEqualTo: levelImage.trailingAnchor, constant: 5)
            
        ])
    }
}
