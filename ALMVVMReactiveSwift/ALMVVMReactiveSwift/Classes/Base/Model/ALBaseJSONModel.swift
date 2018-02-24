//
//  ALBaseJSONModel.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/23.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import EVReflection

class ALBaseJSONModel: EVObject {
    var result: ALResultData = ALResultData()
}

class ALBaseModel: ALBaseJSONModel {
    var data = [String:Any]()
    
    override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
        return [(
            key: "data",
            decodeConverter: {self.data = $0 as! [String : Any]},
            encodeConverter: {return self.data}
            )]
    }
}

class ALResultData: EVObject {
    var code: Int = -1
    var msg: String = ""
    var timeStamp: Int = -1
}
