//
//  ALAccountInfoView.swift
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

class ALAccountInfoView: UIView {
    
    enum ALAccountInfoViewType:Int {
        case ALAccountInfoViewTypeForgetPassword = 0
        case ALAccountInfoViewTypeRegist = 1
    }
    
    required convenience init(type: ALAccountInfoViewType) {
        self.init()
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor(rgbaValue: 0x4B7FEB33).cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        switch type {
        case .ALAccountInfoViewTypeForgetPassword:
            fallthrough
        case .ALAccountInfoViewTypeRegist:
            layoutForgetPasswordAndRegist()
        }
    }

    var accountTF: UITextField?
    var verficationCodeTF: UITextField?
    var passwordTF: UITextField?
    var getCode: UIButton?
    var eyesBtn: UIButton?
    
    private func getNormalItem() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    private func getNormalLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont(.Regular,14)
        view.textColor = UIColor(rgbaValue: 0x666666FF)
        view.setContentHuggingPriority(UILayoutPriority.required, for: UILayoutConstraintAxis.horizontal)
        return view
    }
    
    private func getNormalTextFiled() -> UITextField {
        let view = UITextField()
        view.keyboardType = .phonePad
        view.font = UIFont(.Regular,13)
        view.textAlignment = .left
        view.clearButtonMode = .whileEditing
        return view
    }
    
    private func getLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(rgbaValue: 0xF3F4F8FF)
        return view
    }
    
    private func layoutForgetPasswordAndRegist() {
        
        /*********手机号*********/
        let accoutItem: UIView = {
            let view = getNormalItem()
            self.addSubview(view)
            return view
        }()
        
        accoutItem.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(46)
        }
        
        let accountLab: UILabel = {
            let view = getNormalLabel()
            view.text = "手机号"
            accoutItem.addSubview(view)
            return view
        }()
        
        accountLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(accoutItem)
            make.left.equalTo(16)
        }
        
        let accountTextFiled: UITextField = {
            let view = getNormalTextFiled()
            view.placeholder = "请输入11位手机号码"
            accoutItem.addSubview(view)
            accountTF = view
            return view
        }()
                
        accountTextFiled.snp.makeConstraints { (make) in
            make.centerY.equalTo(accountLab)
            make.left.equalTo(accountLab.snp.right).offset(25)
            make.right.equalTo(-16)
        }
        
        let accountLine: UIView = {
            let view = getLine()
            accoutItem.addSubview(view)
            return view
        }()
        
        accountLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(1)
        }
        
        /*********验证码*********/
        let verficationCodeItem: UIView = {
            let view = getNormalItem()
            self.addSubview(view)
            return view
        }()
        
        verficationCodeItem.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(accoutItem)
            make.top.equalTo(accoutItem.snp.bottom)
        }
        
        let verficationCodeLab: UILabel = {
            let view = getNormalLabel()
            view.text = "验证码"
            verficationCodeItem.addSubview(view)
            return view
        }()
        
        verficationCodeLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(verficationCodeItem)
            make.left.equalTo(16)
        }
        
        let getVerficationCodeButton: UIButton = {
            let view = UIButton(type: .custom)
            view.setTitle("获取验证码", for: .normal)
            view.setTitleColor(UIColor(rgbaValue: 0x4B7FEBFF), for: .normal)
            view.setTitleColor(UIColor(rgbaValue: 0xCACDCFFF), for: .disabled)
            view.titleLabel?.font = UIFont(.Regular,13)
            view.isEnabled = false
            view.setContentHuggingPriority(.required, for: .horizontal)
            verficationCodeItem.addSubview(view)
            getCode = view
            return view
        }()
        
        getVerficationCodeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(verficationCodeItem)
        }
        
        let verticalLine: UIView = {
            let view = getLine()
            verficationCodeItem.addSubview(view)
            return view
        }()
        
        verticalLine.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(1)
            make.centerY.equalTo(verficationCodeItem)
            make.right.equalTo(getVerficationCodeButton.snp.left).offset(-15)
        }
        
        let verficationTextFiled: UITextField = {
            let view = getNormalTextFiled()
            view.placeholder = "请输入验证码"
            verficationCodeItem.addSubview(view)
            verficationCodeTF = view
            return view
        }()
        
        verficationTextFiled.snp.makeConstraints { (make) in
            make.centerY.equalTo(verficationCodeItem)
            make.left.equalTo(verficationCodeLab.snp.right).offset(25)
            make.right.equalTo(verticalLine.snp.left).offset(-10)
        }
        
        let verficationLine: UIView = {
            let view = getLine()
            verficationCodeItem.addSubview(view)
            return view
        }()
            
        verficationLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(1)
        }
        
        /*********密码*********/
        let passowrdItem: UIView = {
            let view = getNormalItem()
            self.addSubview(view)
            return view
        }()
        
        passowrdItem.snp.makeConstraints { (make) in
            make.left.right.equalTo(accoutItem)
            make.height.equalTo(45)
            make.top.equalTo(verficationCodeItem.snp.bottom)
        }
        
        let passwordLab: UILabel = {
            let view = getNormalLabel()
            view.text = "密码"
            accoutItem.addSubview(view)
            return view
        }()
        
        passwordLab.snp.makeConstraints { (make) in
            make.centerY.equalTo(passowrdItem)
            make.left.equalTo(16)
        }
        
        let eyesButton: UIButton = {
            let view = UIButton(type: .custom)
            view.setBackgroundImage(UIImage(named: "icon-Display password"), for: .normal)
            view.setBackgroundImage(UIImage(named: "icon-openeye"), for: .selected)
            passowrdItem.addSubview(view)
            eyesBtn = view
            return view
        }()
        
        eyesButton.snp.makeConstraints { (make) in
            make.right.equalTo(-14)
            make.centerY.equalTo(passowrdItem)
            make.size.equalTo(CGSize(width: 22, height: 23))
        }
        
        let passwordTextFiled: UITextField = {
            let view = getNormalTextFiled()
            view.isSecureTextEntry = true
            view.placeholder = "请输入密码"
            passowrdItem.addSubview(view)
            passwordTF = view
            return view
        }()
        
        passwordTextFiled.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordLab)
            make.left.equalTo(verficationTextFiled)
            make.right.equalTo(eyesButton.snp.left).offset(-10)
        }
    }
    
}
