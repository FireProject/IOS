//
//  PlusFriendViewController.swift
//  IOS
//
//  Created by 장대호 on 2021/03/22.
//

import Foundation
import UIKit

class PlusFriendViewController : UIViewController {
    @IBOutlet weak var friendEmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
