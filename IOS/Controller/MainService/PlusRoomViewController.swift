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

enum enumVoteCycle {
    case month
    case week
    case day
}

class PlusRoomViewController : UIViewController, UITextFieldDelegate,UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var monthCycleButton: UIButton!
    @IBOutlet weak var weekCycleButton: UIButton!
    @IBOutlet weak var dayCycleButton: UIButton!
    @IBOutlet weak var personNumberLabel: UILabel!
    @IBOutlet weak var voteCycleLabel: UILabel!
    var voteCycle:enumVoteCycle = .day
    let picker = UIColorPickerViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColorButton.layer.borderWidth = 1.0
        self.backgroundColorButton.layer.borderColor = CGColor(gray: 1, alpha: 1)
        self.numberSlider.maximumValue = 15
        self.numberSlider.minimumValue = 2
        self.picker.delegate = self
        self.picker.selectedColor = .white
        self.backgroundColorButton.backgroundColor = .white
        self.dayCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
        self.numberSlider.value = 7
        self.personNumberLabel.text = "7명"
        self.voteCycleLabel.text = "투표주기: 00:00 ~ 23:59"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
        
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.navigationItem.title = "채팅방 추가"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    
    func resetButtonImage() {
        monthCycleButton.setImage(nil, for: .normal)
        weekCycleButton.setImage(nil, for: .normal)
        dayCycleButton.setImage(nil, for: .normal)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.backgroundColorButton.backgroundColor = viewController.selectedColor
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
    
    @IBAction func makeRoomButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func backgroundColorButtonAction(_ sender: Any) {
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        self.personNumberLabel.text = "\(Int(sender.value))명"
    }
}
