//
//  ALGetVerficationCodeViewController.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/21.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ALRegisterViewController: ALBaseViewController {
    
    private var countDownTimer: Timer?
    private var countValue:Int = 60 {
        didSet {
            self.accountInfoView.getCode?.setTitle(String(countValue) + "s", for: .normal)
        }
    }
    
    @objc private var countDownFlag = true

    var getVerficationCodeViewModel: ALRegisterViewModel {
        get {
            return self.viewModel as! ALRegisterViewModel
        }
    }

    lazy var accountInfoView: ALAccountInfoView = {
        let view = ALAccountInfoView(type: .ALAccountInfoViewTypeForgetPassword)
        self.view.addSubview(view)
        return view
    }()
    
    lazy var finishedButton: UIButton = {
        let view = UIButton(customType: .ALCustomActionButtonTypeGetVerficationCode)
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = self.viewModel?.params?["title"] as? String {
            self.title = title
        }
    }
    
    override func setUpUI() {
        accountInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.top.equalTo(74)
            make.height.equalTo(137)
        }
        
        finishedButton.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.top.equalTo(accountInfoView.snp.bottom).offset(25)
        }
    }
    
    override func bindModel() {
        BindingTarget(object: getVerficationCodeViewModel, keyPath: #keyPath(ALRegisterViewModel.account)) <~ accountInfoView.accountTF!.reactive.continuousTextValues
        BindingTarget(object: getVerficationCodeViewModel, keyPath: #keyPath(ALRegisterViewModel.verficationCode)) <~ accountInfoView.verficationCodeTF!.reactive.continuousTextValues
        BindingTarget(object: getVerficationCodeViewModel, keyPath: #keyPath(ALRegisterViewModel.passowrd)) <~ accountInfoView.passwordTF!.reactive.continuousTextValues
        
        finishedButton.reactive.isEnabled <~ getVerficationCodeViewModel.finishedEnableSignalProducer
        accountInfoView.eyesBtn?.reactive.controlEvents(.touchUpInside).observeValues { $0.isSelected = !$0.isSelected }
        accountInfoView.passwordTF!.reactive.isSecureTextEntry <~ DynamicProperty<Bool>(object: accountInfoView.eyesBtn!, keyPath: #keyPath(UIButton.isSelected))
        accountInfoView.getCode!.reactive.isEnabled <~ accountInfoView.accountTF!.reactive.continuousTextValues.map { [weak self] (value) in  value!.noEmpty && (self?.countDownFlag)! }
        
        accountInfoView.getCode?.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues({ [weak self] (sender) in
            self?.getVerficationCodeViewModel.getCodeSignalProducer.startWithResult({
                if $0.value != nil {
                    if let weakSelf = self {
                        self?.view.showMessage("获取验证码成功～")
                        weakSelf.countValue = 60
                        weakSelf.accountInfoView.getCode?.isEnabled = false
                        weakSelf.countDownFlag = false
                        weakSelf.countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: weakSelf, selector: #selector(ALRegisterViewController.countDownAction), userInfo: nil, repeats: true)
                        RunLoop.main.add(weakSelf.countDownTimer!, forMode: .commonModes)
                    }
                }
            })
        })
        
        finishedButton.reactive.controlEvents(.touchUpInside).observeResult { [weak self] (sender) in
            self?.getVerficationCodeViewModel.registFinishedActionSignalProducer.startWithResult({
                if $0.value != nil {
                    self?.view.showMessage("登录成功")
                }
            })
        }
    }
    
    @objc func countDownAction() {
        countValue -= 1
        if countValue == -1 {
            self.accountInfoView.getCode?.isEnabled = true
            self.countDownFlag = true
            self.accountInfoView.getCode?.setTitle("获取验证码", for: .normal)
            self.countDownTimer?.invalidate()
            self.countDownTimer = nil
        }
    }
}
