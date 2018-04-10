//
//  JHHelpSectionHeader.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/3/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHHelpSectionHeader: UIView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    typealias CallBackBlock = (_ index : NSInteger, _ isSelected : Bool)->(Void)
    var callBackBlock : CallBackBlock!
}


extension JHHelpSectionHeader {
    // 类函数
    public class func loadHelpSectionView() -> JHHelpSectionHeader {
        return Bundle.main.loadNibNamed("JHHelpSectionHeader", owner: nil, options: nil)?.last as! JHHelpSectionHeader
    }
}

extension JHHelpSectionHeader {
    @IBAction func spreadBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (self.callBackBlock != nil) {
            callBackBlock(self.tag, sender.isSelected)
        }
    }
}
