//
//  JHNetworkingTool.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/26.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}
// 闭包写法   callback:(参数)->()

class JHNetworkingTool {
    class func requestData(_ type:MethodType,  URLString:String,  params:[String:Any]? = nil, finishedCallback:@escaping (_ result : Any)->()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                print("requset error = \(response.result.error!)")
                return
            }
            
            // 将结果回调出去
            finishedCallback(result)
        }
    }
}
