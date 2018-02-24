//
//  ALLoginViewModel.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import Moya

class ALLoginViewModel: ALBaseViewModel {
    
    @objc var account = ""
    @objc var password = ""
        
    var loginEnableSignalProducer: SignalProducer<Bool,NoError>!
    var loginActionSignalProducer: SignalProducer<Bool,ALRequestCommonError>!
    
    override func initialBind() {
        let accountProterty = DynamicProperty<String>(object: self, keyPath: #keyPath(ALLoginViewModel.account))
        let passwordProterty = DynamicProperty<String>(object: self, keyPath: #keyPath(ALLoginViewModel.password))
        
        loginEnableSignalProducer = SignalProducer.combineLatest(accountProterty, passwordProterty).map { $0.0.noEmpty && $0.1.noEmpty }
        
        loginActionSignalProducer = SignalProducer<Bool,ALRequestCommonError>({ [weak self] (observer, _) in
            let provider = ALRequestAPI.sharedInstance()
            //通过moya创建网络请求，map转换成自定义model，on里处理请求各种状态
            provider.reactive.request(.login(account: self?.account ?? "", password: self?.password.MD5 ?? "")).map(to: ALUserModel.self).on(starting: {
                self?.reqeustShowHudObserver.send(value: 3)
            }, failed: { (error) in
                self?.requestCommondErrorObserver.send(value: ALRequestCommonError(error: error))
            }, value: { (userInfomationModel) in
                if userInfomationModel.result.code == 200 {
                    observer.send(value: true)
                } else {
                    self?.requestCommondErrorObserver.send(value: ALRequestCommonError(result: userInfomationModel.result))
                }
                observer.sendCompleted()
            }).take(during: (self?.reactive.lifetime)!).start()
        })
    }
}
