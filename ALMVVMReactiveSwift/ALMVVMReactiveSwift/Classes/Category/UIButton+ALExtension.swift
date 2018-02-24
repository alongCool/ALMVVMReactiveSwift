//
//  UIButton+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/19.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    enum ALCustomActionButtonType:Int {
        case ALCustomActionButtonTypeLogin = 0
        case ALCustomActionButtonTypeGetVerficationCode = 1
    }
    
    convenience init(customType: ALCustomActionButtonType) {
        self.init(type: .custom)
        switch customType {
        case .ALCustomActionButtonTypeLogin:
            self.setTitle("登录", for: .normal)
            self.setBackgroundImage(UIImage(named: "btn-Sign in-activate"), for: .normal)
            self.setBackgroundImage(UIImage(named: "btn-Sign in-Pressed"), for: .highlighted)
            self.setBackgroundImage(UIImage(named: "btn-Sign in-disabled"), for: .disabled)
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor(rgbValue: 0x666666), for: .disabled)
            self.titleLabel?.font = UIFont(.Regular)
            self.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0)
            self.isEnabled = false
        case .ALCustomActionButtonTypeGetVerficationCode:
            self.setTitle("完成", for: .normal)
            self.setBackgroundImage(UIImage(named: "btn_next-nor"), for: .normal)
            self.setBackgroundImage(UIImage(named: "btn-next-pressed"), for: .highlighted)
            self.setBackgroundImage(UIImage(named: "btn-next-disabled"), for: .disabled)
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = UIFont(.Regular)
            self.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0)
            self.isEnabled = false
        }
    }
}
