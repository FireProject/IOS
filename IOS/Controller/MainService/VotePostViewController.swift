//
//  VotePostViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/09.
//

import Foundation
import UIKit

class VotePostViewController:UIViewController {
    var userInfo:VoteViewController.Certification? = nil

    @IBOutlet weak var MemoView: UIView!
    let textView = UnderlinedTextView()
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewSetting()
        textView.text = userInfo?.message
        imageView.image = userInfo?.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func textViewSetting() {
        self.textView.autocorrectionType = .no
        self.textView.autocapitalizationType = .none
        self.textView.smartQuotesType = .no
        self.textView.textContentType = .none
        self.textView.spellCheckingType = .no
        self.textView.smartInsertDeleteType = .no
        self.textView.smartDashesType = .no
        self.textView.isEditable = false
        
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 35)
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.MemoView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: MemoView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: MemoView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: MemoView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: MemoView.bottomAnchor),
        ])
    }
    func setUserInfo(info:VoteViewController.Certification) {
        self.userInfo = info
    }
    @IBAction func exitButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
