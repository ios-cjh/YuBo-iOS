//
//  JHPageView.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHPageView: UIView {
    // MARK:- 定义属性
    fileprivate var style : JHTitleStyle!
    fileprivate var titles : [String]!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : JHTitleView!
    fileprivate var contentView : JHContentView!
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String], style : JHTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
//        assert(titles.count == childVcs.count, "")
        
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
         parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JHPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = JHTitleView (frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self // 控制器成为titleView的代理
        self.addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = JHContentView (frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        self.addSubview(contentView)
    }
}

extension JHPageView : JHTitleViewDelegate {
    func titleView(_ titleView: JHTitleView, electedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}

extension JHPageView : JHContentViewDelegate {
    
    func contentView(_ contentView: JHContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: JHContentView) {
        titleView.contentViewDidEndScroll()
    }
}


