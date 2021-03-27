//
//  ChattingViewTableClass.swift
//  IOS
//
//  Created by 장대호 on 2021/03/27.
//

import Foundation
import UIKit

class ChattingTableCell: UITableViewCell {
    let profileImage = UIImageView()
    let roomName = UILabel()
    let lastMessage = UILabel()
    
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
        roomName.font = .systemFont(ofSize: 17, weight: .bold)
        roomName.textColor = .white
        
        lastMessage.font = .systemFont(ofSize: 17, weight: .bold)
        lastMessage.textColor = .white
    
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 30
        
        contentView.addSubview(profileImage)
        contentView.addSubview(roomName)
        contentView.addSubview(lastMessage)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        roomName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            
            roomName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            roomName.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: -30),
            
            lastMessage.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            lastMessage.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }
}
