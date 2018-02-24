//
//  ALUserModel.swift
//  ALMVVMReactiveSwift
//
//  Created by xlshi on 2018/2/24.
//  Copyright © 2018年 along. All rights reserved.
//

import UIKit
import EVReflection

class ALUserModel: ALBaseJSONModel {
    var data: ALUserIDModel = ALUserIDModel()
}

class ALUserIDModel: EVObject {
    var userId: String = ""
    var uuid: String = ""
}
