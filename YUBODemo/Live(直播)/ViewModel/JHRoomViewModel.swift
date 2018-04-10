//
//  JHRoomViewModel.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/30.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHRoomViewModel: NSObject {
    // 懒加载自定义属性
    lazy var liveURL : String = ""
}

extension JHRoomViewModel {
    func loadLiveURL(_ roomID : Int, _ userID : String, _ complete : @escaping ()->()) {
        let urlString = "http://qf.56.com/play/v2/preLoading.ios"
        let params : [String : Any] = [
            "imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056",
            "roomId" : roomID,
            "signature" : "f69f4d7d2feb3840f9294179cbcb913f",
            "userId" : userID
        ]
        
        JHNetworkingTool.requestData(.get, URLString: urlString, params: params, finishedCallback: { (result) in
            print("loadLiveURL == \(result)")
            /**
        result == {
             message = {
                audioUrl = "http://v-rtmp-ngb.qf.56.com/live/55555_1517282970599?only-audio=1&wsSecret=0c5549d9705777377c7c17545d85ed1a&wsTime=5A6FE861&cid=1&ver=ngb&cip=ngb&get_url=6";
                hd = 2;
                link =  {
                status = 0;
                };
                live = 1;
                push = 1;
                rUrl = "http://v-ngb.qf.56.com/live/55555_1517282970599.flv?wsSecret=0c5549d9705777377c7c17545d85ed1a&wsTime=5A6FE861&cid=3&ver=ngb&cip=ngb&get_url=9";
                sp = 2;
               };
             status = 200;
      }
             */
            // [String : Any] 定义字典
            guard let resultDict = result as? [String : Any] else {return}
            guard let msgDict = resultDict["message"] as? [String : Any] else {return}
            guard let requestURL =  msgDict["rUrl"] as? String else {return} // 获得请求直播的地址
            self.loadOnLiveUrl(requestURL, complete)
        })
    }
    
    fileprivate func loadOnLiveUrl(_ requestURL:String, _ complete : @escaping()->()) {
        
        JHNetworkingTool.requestData(.get, URLString: requestURL, finishedCallback: { (result) in
            print("loadOnLiveUrl = \(result)")
            // 获取结果的字典
            guard let resultDict = result as? [String : Any] else {return}
            
            guard let liveURL = resultDict["url"] as? String else {return}
            
            self.liveURL = liveURL
            
            // 回调出去
            complete()
        })
    }
}
