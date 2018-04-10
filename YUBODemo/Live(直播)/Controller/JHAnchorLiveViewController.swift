//
//  JHHomeLiveViewController.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 8
private let kAnchorCellID = "kAnchorCellID"

class JHAnchorLiveViewController: UIViewController {

    // MARK:- 对外属性
    var typeModel : JHHomeTypeModel!
    
    // MARK:- 定义属性
    fileprivate lazy var homeVM : JHLiveViewModel = JHLiveViewModel()
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = JHWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.dataSource = self
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 100 + (self.tabBarController?.tabBar.frame.height)!, 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        let nib = UINib(nibName: "HomeViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: kAnchorCellID)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData(index:0)
    }
}

extension JHAnchorLiveViewController {
    fileprivate func setupData(index:Int) {        
        if typeModel != nil {
            homeVM.loadLiveData(type: typeModel, index : index, finishedCallback: {
                self.collectionView.reloadData()
            })
        }
    }
}

// MARK -: 设置UI
extension JHAnchorLiveViewController {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
}
// MARK -: 设置UICollectionViewDataSource
extension JHAnchorLiveViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.anchorDataModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorCellID, for: indexPath) as! JHHomeCollectionViewCell
        
        cell.anchorModel = homeVM.anchorDataModelArray[indexPath.item]
        
        
        return cell
    }
}



extension JHAnchorLiveViewController : UICollectionViewDelegate, WaterfallLayoutDataSource {
    func waterfallLayout(_ layout: JHWaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? kScreenW * 2 / 3 : kScreenW * 0.5
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 通知键盘
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = JHRoomLiveViewController()
        roomVc.anchorModel = homeVM.anchorDataModelArray[indexPath.item]
        roomVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(roomVc, animated: true)
    }

}







