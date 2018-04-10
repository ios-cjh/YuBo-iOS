//
//  JHLiveViewController.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHLiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK:- UI处理
extension JHLiveViewController {
    fileprivate func setupUI() {
        setupNav()
        setupContentView()
    }
    
    fileprivate func setupNav() {
        
        let collectImage = UIImage(named: "search_btn_follow")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (image: collectImage, style: .plain, target: self, action: #selector(collectItemClick))
        
        let searchFrame = CGRect (x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar (frame: searchFrame)
        searchBar.placeholder = "昵称、房间号搜索"
        searchBar.searchBarStyle = .minimal
        self.navigationItem.titleView = searchBar
        
        // [UIColor colorWithRed:153 / 255.0 green:214 / 255.0 blue:93 / 255.0 alpha:1.0];
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.orange
        searchFiled?.tintColor = UIColor.init(red: 153 / 255.0, green: 214 / 255.0, blue: 93 / 255.0, alpha: 1.0)
    }
    
    fileprivate func setupContentView() {
        // 数组包含着 模型
        let typeDataArray = loadTypesData()
        
        let style = JHTitleStyle()
        style.isShowCover = true
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - 44)
        
        let titles = typeDataArray.map({$0.title})
        
        // 遍历数组，创建控制器
        var childVcs = [JHAnchorLiveViewController]()
        
        for type in typeDataArray {
            let homeLiveVc = JHAnchorLiveViewController()
            homeLiveVc.typeModel = type
            childVcs.append(homeLiveVc)
        }
        
        let pageView = JHPageView (frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        self.view.addSubview(pageView)
        
    }
    
    fileprivate func loadTypesData() ->[JHHomeTypeModel] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray (contentsOfFile: path) as! [[String : Any]] // [[String : Any]] = 数组里面存放着字典
        // 遍历数组  将数组里的字典转成模型
        var tempArray = [JHHomeTypeModel]()
        for dict in dataArray {
            tempArray.append(JHHomeTypeModel(dict : dict))
        }
        return tempArray
    }

}

// MARK:- 事件处理
extension JHLiveViewController {
    @objc fileprivate func collectItemClick() {
        print("collect----")
    }
}













