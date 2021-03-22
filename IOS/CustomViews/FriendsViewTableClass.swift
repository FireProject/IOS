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
        /*
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        contentView.addSubview(title)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                   constant: 8),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])*/
        
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
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nickLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 13),
            nickLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            
            underLine.heightAnchor.constraint(equalToConstant: 0.5),
            underLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            underLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            underLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
        ])
    }
}
