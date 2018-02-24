//
//  UIView+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/21.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {
    
    //MBProgressHUD
    func showHud() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.backgroundColor = UIColor.black
        hud.show(animated: true)
    }

    func hideHud() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func showMessage(_ message: String) {
        self.hideHud()
        UIApplication.shared.keyWindow?.hideHud()
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.backgroundColor = UIColor.black
        hud.label.textColor = UIColor.white
        hud.hide(animated: true, afterDelay: 2.0)
        hud.label.font = UIFont(.Regular,14)
    }
    
}
