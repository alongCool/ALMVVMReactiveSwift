//
//  UIFont+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/19.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit

enum SystemFontName: String {
    case Regular = ".PingFangSC-Regular"
    case Medium = ".PingFangSC-Medium"
}

extension UIFont {
    convenience init(_ fontName: SystemFontName,_ size: CGFloat) {
        self.init(name: fontName.rawValue, size: size)!
    }
    
    convenience init(_ fontName: SystemFontName) {
        self.init(name: fontName.rawValue, size: 17)!
    }
}


