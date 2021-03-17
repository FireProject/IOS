//
//  MemoView.swift
//  IOS
//
//  Created by 장대호 on 2021/03/17.
//


import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class MemoView: UIView ,UITextViewDelegate{

    @IBOutlet weak var memoTextView: UITextView!
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
        memoTextView.delegate = self
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        memoTextView.delegate = self
    }
    
    private func setup() {
        backgroundColor = .clear
        guard let view = loadView(nibName: "MemoView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

}
