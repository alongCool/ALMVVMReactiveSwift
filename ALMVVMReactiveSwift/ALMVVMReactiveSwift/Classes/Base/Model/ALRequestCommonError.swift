//
//  ALRequestCommonError.swift
//  bbxServerSwift
//
//  Created by xlshi on 2018/2/6.
//  Copyright © 2018年 kuanyinjeji. All rights reserved.
//

import UIKit

class ALRequestCommonError: Swift.Error {

    var resultData: ALResultData?
    var error: Error?
    var abnormal: Bool?
    
    convenience init(error: Error) {
        self.init()
        self.error = error
    }
    
    convenience init(error: Error?, abnormal: Bool) {
        self.init()
        self.error = error
        self.abnormal = abnormal
    }
    
    convenience init(result: ALResultData) {
        self.init()
        self.resultData = result
    }
    
    convenience init(result: ALResultData, abnormal: Bool) {
        self.init()
        self.resultData = result
        self.abnormal = abnormal
    }
}

