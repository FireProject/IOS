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

class PlusRoomViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundColorButton: UIButton!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var monthCycleButton: UIButton!
    @IBOutlet weak var weekCycleButton: UIButton!
    @IBOutlet weak var dayCycleButton: UIButton!
    @IBOutlet weak var personNumberLabel: UILabel!
    var voteCycle:enumVoteCycle = .day
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColorButton.layer.borderWidth = 1.0
        self.backgroundColorButton.layer.borderColor = CGColor(gray: 1, alpha: 1)
        self.numberSlider.maximumValue = 15
        self.numberSlider.minimumValue = 2
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
    
    @IBAction func cycleButtonPressed(_ sender: UIButton){
        resetButtonImage()
        switch sender {
        case dayCycleButton:
            dayCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .day
            break
        case weekCycleButton:
            weekCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .week
            break
        case monthCycleButton:
            monthCycleButton.setImage(#imageLiteral(resourceName: "FireImage"), for: .normal)
            self.voteCycle = .month
            break
        default:
            print("error")
        }
    }
    
    @IBAction func makeRoomButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func backgroundColorButtonAction(_ sender: Any) {
        print("fdsafds")
    }
    
    
    @IBAction func sliderAction(_ sender: Any) {
        
    }
}
