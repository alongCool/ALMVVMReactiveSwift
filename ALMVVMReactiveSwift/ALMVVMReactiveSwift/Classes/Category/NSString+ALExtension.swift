//
//  NSString+ALExtension.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/22.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation

extension String {
    //转换md5
    var MD5 : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(format: hash as String)
    }
    //长度大于0
    var noEmpty : Bool {
        return self.count > 0
    }
}

