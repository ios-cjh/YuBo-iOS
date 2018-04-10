//
//  JHCacheTool.swift
//  YUBODemo
//
//  Created by cjh 2018/1/18.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHCacheTool: NSObject {
    class func fileSizeOfCache() -> Int {
        // 获取缓存文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 获取所有的文件夹数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        var size = 0
        for file in fileArr! { // 遍历所有文件夹
            // 文件名file拼接在路径中
            let path = ( cachePath! as NSString ).appending("/\(file)")
            //[FileAttributeKey : Any]
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元祖取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size = size + (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = size / 1024 / 1024
        return mm
    }
    
    class func clearCache() {
        // 获取缓存文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                }
            }
        }
    }

}
