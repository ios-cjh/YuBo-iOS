//
//  JHContentView.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

protocol JHContentViewDelegate : class  {
    func contentView(_ contentView:JHContentView,progress : CGFloat,sourceIndex:Int, targetIndex:Int)
    
    func contentViewEndScroll(_ contentView :JHContentView)
}

class JHContentView: UIView {
    

    // 对外属性
    weak var delegate : JHContentViewDelegate?
    
    // MARK: 定义属性
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    fileprivate var startOffsetX : CGFloat = 0
    
    // MARK:- 控件属性
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size // 一定要设置。不然系统设置成默认大小
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView (frame: self.bounds, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = self.bounds
        collectionView.isPagingEnabled = true
        collectionView.delegate = self //控制器成为collectionView的代理
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()


    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController) {
        super.init(frame: frame)
        self.childVcs = childVcs
        self.parentVc = parentViewController
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JHContentView {
    fileprivate func setupUI() {
        // 将所有控制器添加到父控制器上
        for  vc in childVcs {
            parentVc.addChildViewController(vc)
        }
        
        // 添加UICollectionView
        self.addSubview(collectionView)
    }
}

// MARK:- 设置UICollectionViewDataSource方法
extension JHContentView : UICollectionViewDataSource { //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加各个控制器的view添加到cell上
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        cell.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
        return cell
    }
}
// MARK:- 设置UICollectionViewDelegate方法
extension JHContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x // startOffsetX用来判断左滑还是右滑动
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // 该方法调用频繁
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 计算上一页的位置
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 计算将要滚动到下一页的位置
            targetIndex = sourceIndex + 1
            // 边界特殊处理
            if targetIndex >= childVcs.count { // 边界特殊处理
                targetIndex = childVcs.count - 1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW { // 完全滑动过去处理
                targetIndex = sourceIndex
                progress = 1
            }
            
        } else {

            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count { // 边界特殊处理
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        // 将滑动的位置传给titleview去滑动到具体的位置
        delegate?.contentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewEndScroll(self)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewEndScroll(self)
        }
    }

}

// MARK:- 对外暴露的方法
extension JHContentView {
    func setCurrentIndex(_ currentIndex : Int) {
        // 偏移量
        let offset = CGFloat(collectionView.frame.width) * CGFloat(currentIndex)
        // 设置collectionview的偏移量
        collectionView.setContentOffset(CGPoint(x:offset,y:0), animated: true)
    }
}




