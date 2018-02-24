//
//  ALBaseViewController.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/18.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class ALBaseViewController: UIViewController {

    var viewModel: ALBaseViewModel?
    
    required init(viewModel: ALBaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(rgbaValue: 0xF5F6FAFF)

        setUpUI()
        bindModel()
        
        if let nav = navigationController, nav.viewControllers.count > 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-back")!, style: .done, target: self, action: #selector(ALBaseViewController.backAction))
        }
        
        self.viewModel?.reqeustShowHudSignal.observe(on: UIScheduler()).observeValues { [weak self] (flag) in
            switch flag {
            case 1:
                self?.view.showHud()
            case 2:
                self?.view.hideHud()
            case 3:
                if let keyWindow = UIApplication.shared.keyWindow {
                    keyWindow.showHud()
                }
            case 4:
                if let keyWindow = UIApplication.shared.keyWindow {
                    keyWindow.hideHud()
                }
            default:
                break
            }
        }
        
        self.viewModel?.requestCommondErrorSignal.observe(on: UIScheduler()).observeValues { [weak self] (requestError) in
            if let error = requestError.error {
                if error.localizedDescription.contains("The request timed out") {
                    self?.view.showMessage("网络链接超时...")
                } else {
                    self?.view.showMessage("网络异常")
                }
            }

            if let result = requestError.resultData {
                if result.code == 600 {
                    //提示错误
                    self?.view.showMessage(result.msg)
                }
            }
        };
    }

    func setUpUI() {}
    func bindModel() {}
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

