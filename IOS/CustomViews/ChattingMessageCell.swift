//
//  ChattingMessageCell.swift
//  IOS
//
//  Created by 장대호 on 2021/04/02.
//

import Foundation
import UIKit
class ChattingMessageCell: UICollectionViewCell {
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userNicknameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
