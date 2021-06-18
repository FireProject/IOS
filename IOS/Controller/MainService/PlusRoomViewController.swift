//
//  PlusRoomViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/25.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseStorage
enum enumVoteCycle {
    case month
    case week
    case day
}

class PlusRoomViewController : UIViewController, UITextFieldDelegate,UIColorPickerViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var monthCycleButton: UIButton!
    @IBOutlet weak var weekCycleButton: UIButton!
    @IBOutlet weak var dayCycleButton: UIButton!
    @IBOutlet weak var personNumberLabel: UILabel!
    @IBOutlet weak var voteCycleLabel: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomNameLabel: UITextField!
    
    
    var voteCycle:enumVoteCycle = .day
    let colorPicker = UIColorPickerViewController()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColorButton.layer.borderWidth = 1.0
        self.backgroundColorButton.layer.borderColor = CGColor(gray: 1, alpha: 1)
        self.numberSlider.maximumValue = 15
        self.numberSlider.minimumValue = 2
        self.colorPicker.delegate = self
        self.colorPicker.selectedColor = .white
        self.backgroundColorButton.backgroundColor = .white
        self.dayCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
        self.numberSlider.value = 7
        self.personNumberLabel.text = "7명"
        self.voteCycleLabel.text = "투표주기: 00:00 ~ 23:59"
        self.roomImage.clipsToBounds = true
        self.roomImage.layer.cornerRadius = self.roomImage.frame.width / 2.15
        
        self.imagePicker.delegate = self
        self.roomImage.contentMode = .scaleAspectFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.navigationItem.title = "채팅방 추가"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func resetButtonImage() {
        monthCycleButton.setImage(nil, for: .normal)
        weekCycleButton.setImage(nil, for: .normal)
        dayCycleButton.setImage(nil, for: .normal)
    }
    
    //배경색 선택시
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.backgroundColorButton.backgroundColor = viewController.selectedColor
        let color = viewController.selectedColor
        print(UIColorToHexString(uiColor: color))
    }
    
    @IBAction func cycleButtonPressed(_ sender: UIButton){
        resetButtonImage()
        switch sender {
        case dayCycleButton:
            dayCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .day
            self.voteCycleLabel.text = "투표주기: 00:00 ~ 23:59"
            break
        case weekCycleButton:
            weekCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .week
            self.voteCycleLabel.text = "투표주기: 매주 일요일"
            break
        case monthCycleButton:
            monthCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .month
            self.voteCycleLabel.text = "투표주기: 매월 1일"
            break
        default:
            print("error")
        }
    }
    
    @IBAction func chattingRoomImageSettingButtonAction(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            roomImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    func openAlbum() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func makeRoomButtonAction(_ sender: Any) {
        
        guard  let backgroundColor = self.backgroundColorButton.backgroundColor, let roomName = self.roomNameLabel.text, let masterUid = Auth.auth().currentUser?.uid
        else {
            return
        }
        let nPerson = Int(self.numberSlider.value)
        let voteCycle = self.voteCycle
        let roomNotice = ""
        let bannedId:[String] = []
        let users:[String] = [masterUid]
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let storage = Storage.storage(url: "gs://fire-71c1d.appspot.com/")
        let backgroundColorString = UIColorToHexString(uiColor: backgroundColor)
        
        var value = [
            "roomName" : roomName,
            "masterUid" : masterUid,
            "maxPerson" : nPerson,
            "curPerson" : 1,
            "voteCycle" : "monthly",
            "bannedUid" : bannedId,
            "users" : users,
            "roomNotice" : roomNotice,
            "backgroundColor" : backgroundColorString
        ] as [String : Any]
        
        switch voteCycle {
        case .day:
            value["voteCycle"] = "day"
            break
        case .month:
            value["voteCycle"] = "month"
            break
        case .week:
            value["voteCycle"] = "week"
            break
        }
        
        let rref = ref.child("rooms").childByAutoId()
        guard let roomId = rref.key else {
            return
        }
        var tmp = userData.roomId
        tmp.append(roomId)
        
        
        var data = Data()
        data = (self.roomImage.image?.jpegData(compressionQuality: 0.8))!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child("rooms").child(roomId).child("profileImage").putData(data, metadata: metaData)
 
        rref.setValue(value)
        ref.child("users/\(masterUid)/roomIds").setValue(tmp)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backgroundColorButtonAction(_ sender: Any) {
        self.present(colorPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        self.personNumberLabel.text = "\(Int(sender.value))명"
    }
}

