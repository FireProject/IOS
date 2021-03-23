//
//  SearchEmailPasswordViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/09.
//

import Foundation
import UIKit
import FirebaseAuth
/**
 비밀번호 초기화 뷰 컨트롤러 ResetPasswordViewController
 
 - 스토리보드 위치 : **BurningUpSignInUp.storyboard 마지막 뷰**
 - Location in storyboard : **BurningUpSignInUp.stroyboard's last view**
 
 
 사용자가 이메일을 입력해 비밀번호 초기화 메일을 보낼 수 있으며 완료버튼으로 종료가능
 User can send passwrod reset email typing user's email, can exit finish button
 */
class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //네비게이션 바는 필요하지 않아 지워줌
        self.navigationController?.navigationBar.isHidden = false
    }
    
    /**
     - 이메일 보내기 버튼 액션 함수. 이메일 보내기 버튼이 눌렸을 경우 호출되는 함수이며 Auth.auth.sendPasswordReset을 통해 비밀번호를 초기화 시킨다.
     - send Email Button Action Function. This function called when sendEmailButton was pressed, reset users password using Auth.auth.sendPasswordReset
     - parameters:
        - sender: 함수에서 사용하지 않음 (not use sender in this function)
     
     */
    @IBAction func sendMailButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email, completion: {
            error in})
        let alert = UIAlertController(title: "메일 전송", message: "메일을 전송 했습니다. 확인해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /**
     - 완료버튼 액션함수. 루트뷰로 되돌아간다.
     - FinishButton Action function. back to the root View Controller
     - parameters:
        - sender: 함수에서 사용하지 않음 (not use sender in this function)
     */
    @IBAction func FinishButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
