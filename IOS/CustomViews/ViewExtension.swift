//
//  ViewExtension.swift
//  IOS
//
//  Created by 장대호 on 2021/03/16.
//

import Foundation
import UIKit
extension UIView {
    func loadView(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    var mainView: UIView? {
        return subviews.first
    }
}
