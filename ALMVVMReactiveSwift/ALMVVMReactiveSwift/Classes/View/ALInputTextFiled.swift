//
//  ALInputTextFiled.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/19.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ALInputTextFiled: UIView {
    
    /// 是否显示显示密码按钮 
    var showExpressPassword: Bool = false
    
    lazy var inputTextFiled: UITextField = {
        let view = UITextField()
        view.font = UIFont(.Regular,14)
        view.clearButtonMode = UITextFieldViewMode.whileEditing
        view.attributedPlaceholder = NSAttributedString.init(string: showExpressPassword ? "请输入您的登录密码" : "请输入您的手机号", attributes: [NSAttributedStringKey.foregroundColor: UIColor(rgbValue: 0xBCBCBC)])
        addSubview(view)
        return view
    }()
    
    lazy var iconIV: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: showExpressPassword ? "icon_password" : "icon_accout")
        addSubview(view)
        return view
    }()
    
    lazy var hLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgbValue: 0x797979)
        addSubview(view)
        return view
    }()
    
    lazy var eyesBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.setBackgroundImage(UIImage(named: "icon-Display password"), for: .selected)
        view.setBackgroundImage(UIImage(named: "icon-openeye"), for: .normal)
        view.isSelected = true
        addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        showExpressPassword ? layoutViewWithPassword() : layoutViewWithAccount()
    }
    
    
    /// 用户账号输入框
    func layoutViewWithAccount() {
        iconIV.snp.makeConstraints { (make) in
            make.left.equalTo(10);
            make.centerY.equalTo(self);
            make.size.equalTo(CGSize(width: 24.0, height: 24.0));
        }
        
        inputTextFiled.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15);
            make.centerY.equalTo(self);
            make.right.equalTo(-14);
        }
        
        hLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.left.bottom.right.equalTo(0);
        }
    }
    
    
    /// 用户密码输入框
    func layoutViewWithPassword() {
        iconIV.snp.makeConstraints { (make) in
            make.left.equalTo(10);
            make.centerY.equalTo(self);
            make.size.equalTo(CGSize(width: 24.0, height: 24.0));
        }
        
        hLineView.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.left.bottom.right.equalTo(0);
        }
        
        eyesBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 22, height: 23))
        }
        
        inputTextFiled.snp.makeConstraints { (make) in
            make.left.equalTo(iconIV.snp.right).offset(15);
            make.centerY.equalTo(self);
            make.right.equalTo(eyesBtn.snp.left).offset(-6);
        }
    }
}
