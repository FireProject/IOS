//
//  FriendsViewTableClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/21.
//

import Foundation
import UIKit
class MyCustomHeader: UITableViewHeaderFooterView {
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

class customCell: UITableViewCell {
    let profileImage = UIImageView()
    let nickLabel = UILabel()
    
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
    
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 30
        
        contentView.addSubview(profileImage)
        contentView.addSubview(nickLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            
            nickLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            nickLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }
}
