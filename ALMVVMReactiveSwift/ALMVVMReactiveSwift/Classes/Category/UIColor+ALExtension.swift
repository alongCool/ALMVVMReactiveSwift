//
//  UIColor+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgbValue: UInt32) {
        self.init(red:CGFloat((rgbValue & 0xff0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0xff00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0xff) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgbaValue: UInt32) {
        self.init(red:CGFloat((rgbaValue & 0xff000000) >> 24) / 255.0, green: CGFloat((rgbaValue & 0xff0000) >> 16) / 255.0, blue: CGFloat((rgbaValue & 0xff00) >> 8) / 255.0, alpha: CGFloat(rgbaValue & 0xff) / 255.0)
    }
}


