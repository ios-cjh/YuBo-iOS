//
//  JHTitleStyle.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit
class JHTitleStyle {
    /// 是否显示遮盖
    var isShowCover : Bool = false
    /// 是否是滚动的Title
    var isScrollEnable : Bool = false
    /// 普通Title颜色
    var normalColor : UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0 )
    /// 选中Title颜色 // UIColor(r: 255, g: 127, b: 0)
    var selectedColor : UIColor = UIColor.init(red: 255 / 255.0, green: 127 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    /// 遮盖背景颜色
    var coverBgColor : UIColor = UIColor.lightGray
    /// 遮盖的高度
    var coverH : CGFloat = 25
    /// 设置圆角大小
    var coverRadius : CGFloat = 4
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2


}
