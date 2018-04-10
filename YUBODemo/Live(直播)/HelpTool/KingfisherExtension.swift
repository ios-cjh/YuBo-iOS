//
//  KingfisherExtension.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/29.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(_ URLString : String?, _ placeHolderName : String? = nil) {
        guard let URLString = URLString else {
            return
        }
        
        guard let url = URL (string: URLString) else {
            return
        }
        
        guard let placeHolderName = placeHolderName else {
            kf.setImage(with: url)
            return
        }
        
        kf.setImage(with: url, placeholder : UIImage(named: placeHolderName))
    }
}
