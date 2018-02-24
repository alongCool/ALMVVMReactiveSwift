//
//  ALBaseViewModel.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ALBaseViewModel: NSObject {

    var params: [String: AnyObject]?
    /* 显示hud
     1 showHud in Controller
     2 hideHud in Controller
     3 showHud in KeyWindow
     4 hideHud in KeyWindow
     */
    let (reqeustShowHudSignal,reqeustShowHudObserver) = Signal<Int,NoError>.pipe()
    //处理网络请求的错误
    let (requestCommondErrorSignal,requestCommondErrorObserver) = Signal<ALRequestCommonError,NoError>.pipe()

    override init() {
        super.init()
        initialBind()
    }
    
    convenience init(params: [String: AnyObject]) {
        self.init()
        self.params = params
    }
    
    func initialBind() {}
}
