//
//  JHinfinityScrollViewController.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/3/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHinfinityScrollViewController: UIViewController {
    

    let SCRRENW = UIScreen.main.bounds.size.width
    let SCRRENH = UIScreen.main.bounds.size.height
    
    var dataArr : NSMutableArray = NSMutableArray.init()
    var scrollView : UIScrollView = UIScrollView.init()
    var page : UIPageControl = UIPageControl.init()
    var timer : Timer!
    var tapGR : UITapGestureRecognizer = UITapGestureRecognizer.init()
    var bigPicImageView : UIImageView = UIImageView.init()
    var flag : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false//不允许自动适配位置
        self.navigationItem.title = "无限轮播图"
        self.navigationController?.navigationBar.isTranslucent = true // isTranslucent半透明
        setUpUI()
        
    }
}

// MARK:- UI界面
extension JHinfinityScrollViewController {
    fileprivate func setUpUI() {
        self.initNavItem()//更改导航栏上item
        self.initData()//初始化数据
        self.createScrollView()//创建轮播图
        self.addPicture()//添加轮播图图片
        self.addTimer()//添加定时器
        self.createbigPic()//添加图片浏览视图
    }
    
    fileprivate func initNavItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "继续", style: UIBarButtonItemStyle.plain, target: self, action: #selector(go))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "暂停", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pause))
    }
    
    fileprivate func createScrollView() {
       scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCRRENW, height: 200))
        scrollView.contentSize = CGSize.init(width: CGFloat(dataArr.count) * SCRRENW, height: 0)
        scrollView.backgroundColor = UIColor.white//背景色
        scrollView.showsHorizontalScrollIndicator = false//去除水平滚动条
        scrollView.isPagingEnabled = true//单页
        scrollView.delegate = self//代理方法
        self.view.addSubview(scrollView)
        
        let sheight : CGFloat = scrollView.frame.size.height
        let sorigin : CGFloat = scrollView.frame.origin.y
        
        page = UIPageControl.init(frame: CGRect.init(x:SCRRENW/2 - 50, y: sorigin + sheight - 20 , width: 100, height: 15))
        page.numberOfPages = dataArr.count//点控制数量
        page.currentPage = 0//当前所在页面
        page.pageIndicatorTintColor = UIColor.red//未选中颜色
        page.currentPageIndicatorTintColor = UIColor.green//当前选中颜色
        self.view.addSubview(page)//添加到主视图
    }
    
    fileprivate func addPicture(){
        for i in 0...dataArr.count - 1 {
            let imageV : UIImageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * SCRRENW, y: 0, width: SCRRENW, height: 200))
             imageV.isUserInteractionEnabled = true
            imageV.image = UIImage.init(named: dataArr[i] as! String)
            
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(tapGREvent(_ :)))
            imageV.addGestureRecognizer(tap)
            
            scrollView.addSubview(imageV)
        }
    }
    
    fileprivate func createbigPic() {
        bigPicImageView.frame = CGRect.init(x: 0, y: 0, width: SCRRENW, height: SCRRENH)
        bigPicImageView.backgroundColor = UIColor.orange
        bigPicImageView.contentMode = .scaleAspectFit
        bigPicImageView.isUserInteractionEnabled = true
        
        let smallTapGR = UITapGestureRecognizer.init(target: self, action: #selector(smallPic(tapGR:)))
        bigPicImageView.addGestureRecognizer(smallTapGR)
    }
}

// MARK:- 初始化数据
extension JHinfinityScrollViewController {
    fileprivate func initData() {
        for i in 0...3 {
            let picName : NSString = NSString.init(string: "\(i + 1).jpg")
            dataArr.add(picName)
        }
    }
}

// MARK:- 事件处理
extension JHinfinityScrollViewController {

    @objc fileprivate func tapGREvent(_ tapGR:UITapGestureRecognizer) {
        bigPicImageView.image = (tapGR.view as! UIImageView).image
        self.view.addSubview(bigPicImageView)
        
        if flag {
            timer.invalidate()
            flag = false
            self.navigationController?.isNavigationBarHidden = true //隐藏导航栏
            self.navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    @objc fileprivate func smallPic(tapGR : UITapGestureRecognizer) {
        bigPicImageView.removeFromSuperview()
        self.addTimer()
        flag = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc fileprivate func go() {
        self.addTimer()
    }
    
    @objc fileprivate func pause() {
        timer.invalidate()
    }
}

// MARK:- 定时器事件
extension JHinfinityScrollViewController {
    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
        // ios只有一个主线程处理UI, 如果拖动第二个,第一个UI事件就会失效
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    @objc fileprivate func timerEvent(){
        
        let index : Int = Int(scrollView.contentOffset.x / SCRRENW)
        
        if index >= 3 {
            page.currentPage = 0
            scrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        } else {
            page.currentPage = index + 1
            scrollView.contentOffset = CGPoint.init(x: CGFloat(CGFloat(index + 1) * SCRRENW), y: 0)
        }
    }
}

// MARK:- 代理
extension JHinfinityScrollViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        page.currentPage = Int(scrollView.contentOffset.x / SCRRENW)
    }
}



