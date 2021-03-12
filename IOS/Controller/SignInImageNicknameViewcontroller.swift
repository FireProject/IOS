//
//  SignInImageNicknameViewcontroller.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignInImageNicknameViewcontroller: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2.25
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    @IBAction func ImageChangeButtonPressed(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.nickNameTextField.text = "닉네임"
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField.text == "닉네임" {
            self.nickNameTextField.text = ""
        }
    }
    @IBAction func NextButtonPressed(_ sender: Any) {
        guard let nickName = self.nickNameTextField.text else {
            return
        }
        if nickName == "닉네임" || nickName == "" {
            let alert = UIAlertController(title: "오류", message: "닉네임을 입력해 주십쇼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.navigationController?.popToRootViewController(animated: true)
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users/\(user.uid)/nikname").setValue(nickName)
       // ref.child("users/\(user.uid)/profile").setValue(self.profileImage.image)
        ref.child("users/\(user.uid)/stateMessage").setValue("")
        ref.child("users/\(user.uid)/friends").setValue([])
        ref.child("users/\(user.uid)/roomId").setValue([])
        let storyboard = UIStoryboard(name: "BurningUpMain", bundle: nil)
        let pushController = storyboard.instantiateViewController(withIdentifier: "BurningUpMain")
        pushController.modalPresentationStyle = .fullScreen
        self.present(pushController, animated: true, completion: nil)
    }
}
