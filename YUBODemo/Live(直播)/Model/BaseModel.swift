//
//  BaseModel.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    override init() {
        
    }
    // 字典转模型
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
