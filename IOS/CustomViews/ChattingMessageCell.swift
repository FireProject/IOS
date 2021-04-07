//
//  ChattingMessageCell.swift
//  IOS
//
//  Created by 장대호 on 2021/04/02.
//

import Foundation
import UIKit
class ChattingMessageCell: UICollectionViewCell {
    
    enum messageType {
        case user
        case otherUser
        case otherUserNotProfile
    }
    
    var userNicknameLabel:UILabel = UILabel()
    var userProfileImage:UIImageView = UIImageView()
    var messageLabel: UILabel = UILabel()
    var messageType = ChattingMessageCell.messageType.otherUser
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setting()
    }
    
    func setMessageType(type: ChattingMessageCell.messageType) {
        self.messageType = type
        removeSubViews()
        switch self.messageType {
        case .otherUser:
            constraintOtherUser()
            break
        case .otherUserNotProfile:
            constraintOtherUserNotProfile()
            break
        case .user:
            constraintUser()
            break
        }
        
    }
    
    func setting() {
        self.contentView.backgroundColor = .black
        self.messageLabel.backgroundColor = .gray
        self.messageLabel.layer.masksToBounds = true
        self.messageLabel.layer.cornerRadius = 10
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.numberOfLines = 0
        self.messageLabel.sizeToFit()
        
        
        removeSubViews()
        switch self.messageType {
        case .otherUser:
            constraintOtherUser()
            break
        case .otherUserNotProfile:
            constraintOtherUserNotProfile()
            break
        case .user:
            constraintUser()
            break
        }

    }
    func removeSubViews() {
        let _ = self.contentView.subviews.map({$0.removeFromSuperview()})
    }
    func constraintOtherUser() {
        contentView.addSubview(userProfileImage)
        contentView.addSubview(userNicknameLabel)
        contentView.addSubview(messageLabel)
        
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            userProfileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userProfileImage.heightAnchor.constraint(equalToConstant: 30),
            userProfileImage.widthAnchor.constraint(equalToConstant: 30),
            
            userNicknameLabel.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor, constant: 5),
            userNicknameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userNicknameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            messageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    func constraintOtherUserNotProfile() {
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            messageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
    }
    func constraintUser() {
   
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            messageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
    }
}
