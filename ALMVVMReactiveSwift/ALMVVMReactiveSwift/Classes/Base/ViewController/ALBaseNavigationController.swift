//
//  ALBaseNavigationController.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit

class ALBaseNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    var popDelegate: UIGestureRecognizerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }
        else {
            self.interactivePopGestureRecognizer!.delegate = nil
        }
    }
    
}
