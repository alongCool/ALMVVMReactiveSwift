//
//  ALLoginViewController.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ALLoginViewController: ALBaseViewController {

    lazy var loginViewModel = {
        return self.viewModel as! ALLoginViewModel
    }()
    
    lazy var loginButton: UIButton = {
        let view = UIButton(customType: .ALCustomActionButtonTypeLogin)
        self.view.addSubview(view)
        return view
    }()
    
    lazy var passwordTextField: ALInputTextFiled = {
        let view = ALInputTextFiled()
        view.showExpressPassword = true
        self.view.addSubview(view)
        return view
    }()
    
    lazy var accountTextField: ALInputTextFiled = {
        let view = ALInputTextFiled()
        self.view.addSubview(view)
        return view
    }()
    
    lazy var registUserButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle("立即注册", for: .normal)
        view.titleLabel?.font = UIFont(.Regular,15)
        view.setTitleColor(UIColor(rgbaValue: 0x4B7FEBFF), for: .normal)
        view.setTitleColor(UIColor.darkGray, for: .highlighted)
        self.view.addSubview(view);
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUI() {
        /// 登录按钮
        self.loginButton.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.left.equalTo(35)
            make.right.equalTo(-35)
        }
        
        /// 密码输入框
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(loginButton)
            make.bottom.equalTo(loginButton.snp.top).offset(-38)
            make.height.equalTo(40)
        }
        
        /// 账号输入框
        self.accountTextField.snp.makeConstraints { (make) in
            make.centerX.width.height.equalTo(passwordTextField)
            make.bottom.equalTo(passwordTextField.snp.top).offset(-25)
        }
        
        ///立即注册
        self.registUserButton.snp.makeConstraints { (make) in
            make.right.equalTo(-45)
            make.top.equalTo(loginButton.snp.bottom).offset(15)
        }
    }
    
    override func bindModel() {
        BindingTarget(object: loginViewModel, keyPath: #keyPath(ALLoginViewModel.account)) <~ accountTextField.inputTextFiled.reactive.continuousTextValues
        BindingTarget(object: loginViewModel, keyPath: #keyPath(ALLoginViewModel.password)) <~ passwordTextField.inputTextFiled.reactive.continuousTextValues
        loginButton.reactive.isEnabled <~ loginViewModel.loginEnableSignalProducer
        
        passwordTextField.inputTextFiled.reactive.isSecureTextEntry <~ DynamicProperty<Bool>(object: passwordTextField.eyesBtn, keyPath: #keyPath(UIButton.isSelected))
        passwordTextField.eyesBtn.reactive.controlEvents(.touchUpInside).observeValues { $0.isSelected = !$0.isSelected }
        
        registUserButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
            self?.navigationController?.pushViewController(ALRegisterViewModel(params: ["title": "立即注册" as AnyObject]).toViewController(), animated: true)
        }
        
        loginButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (sender) in
            self?.loginViewModel.loginActionSignalProducer.startWithResult {
                if $0.value != nil {
                    self?.view.showMessage("登录成功！")
                }
            }
        }
    }
    
}

