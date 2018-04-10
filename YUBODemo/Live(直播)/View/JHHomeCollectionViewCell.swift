//
//  JHHomeTableViewCell.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/26.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit
import Kingfisher

class JHHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var onlineLabel: UIButton!
    
    // MARK:- 定义属性 对外暴露模型接口
    var anchorModel : JHAnchorDataModel? {
        didSet {
            
            self.iconImageView.kf.setImage(with: ImageResource (downloadURL: URL(string: (anchorModel?.pic51)!)!))
            self.liveImageView.isHidden = anchorModel?.live == 0
            self.nameLabel.text = anchorModel?.name
            self.onlineLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
}
