//
//  ALViewController+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2018/2/6.
//  Copyright © 2018年 kuanyinjeji. All rights reserved.
//

import Foundation

extension ALBaseViewModel {
    func toViewController() -> ALBaseViewController {
        let viewModelClassName = String(describing: type(of: self))
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let controllerClassName = clsName + "." + viewModelClassName.replacingOccurrences(of: "Model", with: "Controller")
        if let cls = NSClassFromString(controllerClassName) as? ALBaseViewController.Type {
            return cls.init(viewModel: self)
        } else {
            assert(false, "无法转换controller")
        }
    }
}
