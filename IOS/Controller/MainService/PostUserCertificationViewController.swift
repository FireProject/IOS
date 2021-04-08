//
//  PostUserCertificationViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/08.
//

import Foundation
import UIKit

class PostUserCertificationViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var MemoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        
    }
    func setting() {
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let textView = UnderlinedTextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.MemoView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: MemoView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: MemoView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: MemoView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: MemoView.bottomAnchor),
        ])
    }
    @IBAction func exitButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

class UnderlinedTextView: UITextView {
  var lineHeight: CGFloat = 13.8

  override var font: UIFont? {
    didSet {
      if let newFont = font {
        lineHeight = newFont.lineHeight
      }
    }
  }

  override func draw(_ rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.setStrokeColor(UIColor.black.cgColor)
    let numberOfLines = Int(rect.height / lineHeight)
    let topInset = textContainerInset.top

    for i in 1...numberOfLines {
      let y = topInset + CGFloat(i) * lineHeight

      let line = CGMutablePath()
      line.move(to: CGPoint(x: 0.0, y: y))
      line.addLine(to: CGPoint(x: rect.width, y: y))
      ctx?.addPath(line)
    }

    ctx?.strokePath()

    super.draw(rect)
  }
}
