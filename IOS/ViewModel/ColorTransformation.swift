//
//  ColorTransformation.swift
//  IOS
//
//  Created by 장대호 on 2021/05/10.
//

import Foundation
import UIKit
func UIColorToHexString(uiColor:UIColor) -> String{
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    
    uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    
    return NSString(format:"#%06x", rgb) as String
}



func HexStringToUIColor(hexColor:String) -> UIColor {
    guard let intColor = Int(hexColor) else {
        return UIColor()
    }
    let r = (intColor >> 16) & 0xFF
    let g = (intColor >> 8) & 0xFF
    let b = intColor & 0xFF
    
    return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
}
