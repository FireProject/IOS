//
//  PostUserCertificationViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/04/08.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PostUserCertificationViewController: UIViewController  {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var MemoView: UIView!
    @IBOutlet weak var plusPictureButton: UIButton!
    let textView = UnderlinedTextView()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        self.picker.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setting() {
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        plusPictureButton.clipsToBounds = true
        plusPictureButton.layer.cornerRadius = 30
        plusPictureButton.layer.borderWidth = 1.5
        plusPictureButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
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
    @IBAction func exitButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getPictureAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "프로필 사진 설정", message: nil, preferredStyle: .actionSheet)
        let album = UIAlertAction(title: "앨범에서 가져오기", style: .default) { (action) in
            self.openAlbum()
        }
        let camera = UIAlertAction(title: "사진찍기", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(album)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    func openAlbum() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func clearButtonAction(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid,
              let roomId = currentRoom?.roomId else {
            print("error Hello good")
            return
        }
        guard let image = self.imageView.image else {
            let alert = UIAlertController(title: "에러", message: "사진은 필수입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let tmpDate = DateFormatter()
        tmpDate.dateFormat = "YYYYMMdd"
        let date = tmpDate.string(from: Date())
        //등록시에 날짜가 변경되는 순간인지 확인
        //투표 주기에따른 date 형식 달라야함
        //매일 : 연월일, 매달 : 연월, 매주: 연주차
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storage = Storage.storage(url: "gs://fire-71c1d.appspot.com/")
        
        
        //"Certification"/roomId/date/uid/message
        ref.child("certification").child(roomId).child(date).child(uid).child("message").setValue(self.textView.text)
        
        var data = Data()
        data = (image.jpegData(compressionQuality: 0.8))!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child("rooms/\(roomId)/\(date)/\(uid)/postImage").putData(data, metadata: metaData)
        //rooms/roomId/date/uid/postImage
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostUserCertificationViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
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
