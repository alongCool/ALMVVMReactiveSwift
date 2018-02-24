//
//  ALGetVerficationCodeViewModel.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/21.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

class ALRegisterViewModel: ALBaseViewModel {
    
    @objc var account = ""
    @objc var verficationCode = ""
    @objc var passowrd = ""
        
    var finishedEnableSignalProducer: SignalProducer<Bool,NoError>!
    var registFinishedActionSignalProducer: SignalProducer<Bool,ALRequestCommonError>!
    var getCodeSignalProducer: SignalProducer<Bool,ALRequestCommonError>!
    
    override func initialBind() {
        let accountProterty = DynamicProperty<String>(object: self,keyPath: #keyPath(ALRegisterViewModel.account))
        let verficationCodeProterty = DynamicProperty<String>(object: self,keyPath: #keyPath(ALRegisterViewModel.verficationCode))
        let passwordProterty = DynamicProperty<String>(object: self,keyPath: #keyPath(ALRegisterViewModel.passowrd))
        
        finishedEnableSignalProducer = SignalProducer.combineLatest(accountProterty,verficationCodeProterty,passwordProterty).map { $0.0.noEmpty && $0.1.noEmpty && $0.2.noEmpty }
        
        getCodeSignalProducer = SignalProducer<Bool,ALRequestCommonError> { [weak self] (observer, _) in
            let provider = ALRequestAPI.sharedInstance()
            provider.reactive.request(.getCode(account: self?.account ?? "")).map(to: ALBaseModel.self).on(starting: {
                self?.reqeustShowHudObserver.send(value: 1)
            },failed: {
                self?.requestCommondErrorObserver.send(value: ALRequestCommonError(error: $0))
            } ,value: {
                if $0.result.code == 200 {
                    observer.send(value: true)
                } else {
                    self?.requestCommondErrorObserver.send(value: ALRequestCommonError(result: $0.result))
                }
                observer.sendCompleted()
            }).take(during: (self?.reactive.lifetime)!).start()
        }
        
        registFinishedActionSignalProducer = SignalProducer<Bool,ALRequestCommonError> { [weak self] (observer, _) in
            let provider = ALRequestAPI.sharedInstance()
            provider.reactive.request(.registerSecurity(account: self?.account ?? "", newPassword: self?.passowrd.MD5 ?? "", code: self?.verficationCode ?? "")).map(to: ALUserModel.self).on(value: {
                if $0.result.code == 200 {
                    observer.send(value: true)
                } else {
                    self?.requestCommondErrorObserver.send(value: ALRequestCommonError(result: $0.result))
                }
                observer.sendCompleted()
            }).take(during: (self?.reactive.lifetime)!).start()
        }
    }
}
