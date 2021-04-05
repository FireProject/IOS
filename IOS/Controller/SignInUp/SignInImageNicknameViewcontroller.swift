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
import FirebaseStorage

/**
 프로필 사진과 닉네임을 설정하는 뷰 컨트롤러 View Controller setting Profile and Nickname
 
 - 스토리보드 위치 : **BurningUpSignInUp.storyboard 네번째뷰**
 - Location in storyboard  : **BurningUpSignInUp.storyboard 's fourth view **
 
 사용자의 프로필 사진과 닉네임을 Firebase 디비와 Storage 에 저장하고 root 뷰로 돌아감
 
 Save the user's profile image & nickname to Firebase Database & Storage and Go back to the root View
 */

class SignInImageNicknameViewcontroller: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    let storage = Storage.storage(url: "gs://fire-71c1d.appspot.com/")
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self

        //이미지를 둥그렇게 설정
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2.265
        
        self.profileImage.image = userData.profileImage
        if userData.nickname != "" {
            self.nickNameTextField.text = userData.nickname
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        //뷰를 터치하는경우 수정을 끝냄 즉 키보드 다시 내려감
        self.view.endEditing(true)
    }
    
    /**
     이미지 교체 버튼 액션 함수 image change button action button
     
     - parameters:
        - sender: 사용안함 (Not use)
     
     Alert를 띄워서 앨범에서 선택하거나 사진을 찍어 설정할 수 있음
     
     Can set the profileimage by selecting album or taking picture
     and user can see this two option in Alert
     */
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
    /*
     * 사진과 앨범의 경우에따른 설정 함수
     */
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    func openAlbum() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    /*
     * when imagePick is finish this function called
     * 이미지 선택이 완료되면 이 함수가 호출됨
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
     * 텍스트필드 수정이 완료 시작시 특정 문자열이면 수정해줌
     */
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
    /*
     *  다음 버튼 누를 시
     *  확인할것들 모두 확인후 유저데이터를 DB에 저장함
     *  사진은 Storage에 저장
     */
    @IBAction func NextButtonPressed(_ sender: Any) {
        
        //옵셔널 바인딩 및 닉네임 확인
        guard let nickName = self.nickNameTextField.text else {
            return
        }
        if nickName == "닉네임" || nickName == "" {
            let alert = UIAlertController(title: "오류", message: "닉네임을 입력해 주십쇼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        guard let email = user.email?.data(using: .utf8)!.map({String(format:"%02x", $0)}).joined() else {
            return
        }
        
        //디비에 저장하는 코드
        var ref: DatabaseReference!
        ref = Database.database().reference()
       
        var data = Data()
        data = (self.profileImage.image?.jpegData(compressionQuality: 0.8))!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(user.uid).putData(data, metadata: metaData)
        
        ref.child("users/\(user.uid)/nickName").setValue(nickName)
        ref.child("users/\(user.uid)/stateMessage").setValue("")
        ref.child("users/\(user.uid)/email").setValue(user.email)
        
        
        ref.child("emailToUid/\(String(describing: email))").setValue(user.uid)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
