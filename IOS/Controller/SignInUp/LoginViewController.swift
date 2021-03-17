//
//  LoginController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/08.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController : UIViewController , UITextFieldDelegate {
        
    //이메일,비밀번호 텍스트 필드
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //뷰가 열린뒤 이메일, 비번 관리를 컨트롤러가 해준다.
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self

        AutoLogin()
    }
    
    //뷰가 백그라운드에서 나오던 처음 나오던 내비게이션바 숨김
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //뷰를 터치할시 키보드 사라지게끔
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func AutoLogin() {
        guard let email = UserDefaults.standard.string(forKey: "Email") else { return }
        
        guard let password = UserDefaults.standard.string(forKey: "Password") else { return }
        passwordTextField.isSecureTextEntry = true
        self.emailTextField.text = email
        self.passwordTextField.text = password
        self.loginButton.sendActions(for: .allEvents)
    }
    
    //텍스트필드가 클릭될때 특정조건에따라 ""로 만들어줌
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            if self.emailTextField.text == "Email"{
                self.emailTextField.text = ""
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "Password" {
                self.passwordTextField.isSecureTextEntry = true
                self.passwordTextField.text = ""
            }
        default:
            print("error")
        }
    }
    
    //텍스트필드에 아무것도 없으면 초기값으로 다시변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            if self.emailTextField.text == "" {
                self.emailTextField.text = "Email"
            }
        case self.passwordTextField:
            if self.passwordTextField.text == "" {
                self.passwordTextField.isSecureTextEntry = false
                self.passwordTextField.text = "Password"
            }
        default:
            print("error")
        }
    }
    
    //로그인 버튼이 눌렸을때
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        //이메일,패스워드 nil 검사
        
        //로그인 함수
        Auth.auth().signIn(withEmail: email, password: password) { (user,error) in
            
            //에러발생시 출력
            if let error = error  {
                var errorMessage = ""
                switch error ._code {
                case AuthErrorCode.invalidEmail.rawValue:
                    errorMessage = "이메일 형식을 확인해 주세요"
                    break
                case AuthErrorCode.userDisabled.rawValue:
                    errorMessage = "해당계정은 사용이 중지되었습니다."
                    break
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "비밀번호 확인해주세요"
                    break
                case AuthErrorCode.userNotFound.rawValue:
                    errorMessage = "존재하지 않는 이메일입니다."
                    break
                default:
                    print(error)
                    errorMessage = "개발자에게 연락주세요"
                    break
                }
                
                let alert = UIAlertController(title: "오류", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
            guard let user = user?.user else {
                return
            }
            //유저 잘 있는지 검사
            
            //이메일 검사가 아직안되었으면 뷰이동 허가하지않음
            if user.isEmailVerified == false {
                let alert = UIAlertController(title: "이메일 인증이 되지않았습니다.", message: "메일을 재전송 했습니다. 확인해 주세요.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                user.sendEmailVerification(completion: {
                    error in
                })
                return
            }
            
            UserDefaults.standard.set(email, forKey: "Email")
            UserDefaults.standard.set(password, forKey: "Password")
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              let value = snapshot.value as? NSDictionary
              let username = value?["nickname"] as? String ?? ""
              print(username)
              }) { (error) in
                print("teafd")
                print(error.localizedDescription)
            }
            
            
            //실제서비스 뷰 이동
            let storyboard = UIStoryboard(name: "BurningUpMain", bundle: nil)
            let pushController = storyboard.instantiateViewController(withIdentifier: "BurningUpMainNavigation")
            pushController.modalPresentationStyle = .fullScreen
            self.present(pushController, animated: true, completion: nil)
        }
    }
}
