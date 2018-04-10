//
//  JHLIveViewModel.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/26.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHLiveViewModel {
    // 懒加载定义一个数组， 用于存放请求回来的数据
    lazy var anchorDataModelArray = [JHAnchorDataModel]()
}

extension JHLiveViewModel {
    func loadLiveData(type:JHHomeTypeModel,  index:Int,  finishedCallback:@escaping()->()) {
        
        JHNetworkingTool.requestData(.get, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", params: ["type" : type.type, "index" : index, "size" : 48],finishedCallback:{ (result) -> Void in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            
            for (index, dict) in dataArray.enumerated() {
                let anchor = JHAnchorDataModel(dict: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorDataModelArray.append(anchor)
            }

            finishedCallback()
        })
    }
}

