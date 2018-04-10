//
//  JHChatToolsView.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/29.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHChatToolsView: UIView {

    @IBOutlet weak var inputTextField: UITextField!
}

extension JHChatToolsView {
    // +类函数 返回
    class func loadChatToolsView() ->JHChatToolsView {
        return Bundle.main.loadNibNamed("JHChatToolsView", owner: nil, options: nil)?.first as! JHChatToolsView
    }
}
