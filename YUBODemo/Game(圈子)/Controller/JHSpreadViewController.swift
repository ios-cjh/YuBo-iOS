//
//  JHSpreadViewController.swift
//  YUBODemo
//
//  Created by cjh on 2018/3/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit


class JHSpreadViewController: UIViewController {
    
    fileprivate var cellID = "cellID"
    
    //MARK:- 懒加载
    lazy var tableView = {() -> UITableView in
        let tempTabview = UITableView (frame: self.view.bounds, style: .plain)
        tempTabview.delegate = self
        tempTabview.dataSource = self
        tempTabview.backgroundColor = UIColor.white
        tempTabview.tableFooterView = UIView()
        return tempTabview
    }()
    
    var sentionTitles : [String] = {
        return ["开启设备","未能链接WIFI","配置网络/重置网络","声波配网失败原因"]
    }()
    
    lazy var cellTextArray : [String] = {
        return ["还不会如何开启设备吗？点击设备上的开 机按钮，设备会启动，听到开机音乐就证 明设备启动啦！",
                "有可能是您的手机未启用WIFI网络。您可 以在手机的”设置”>“WLAN”中选择一个 可用的WIFI接入。如果您已接入WIFI网络， 请检查WIFI热点是否已接入互联网，或该 热点是否已允许您的设备访问互联网。",
                "配置网络时，需要先将设备调至配置网络 模式，当听到 可以配网的提示音后，即可 进行配网操作。进入配网模式，请按住设 备 上一首按键 5秒钟以上即可。",
                "声波配网目前不支持5G WIFI信号、请先 看下是否连接了可用WIFI。另外根据声音 的反馈，也可以定位到问题所在，例如密 码输入错误。如果手机音量较小，或配网 距离设备较远，请调大音量，并靠近设备 再次重试。"]
    }()
    
    let flagArray : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
}

// MARK:- UI界面
extension JHSpreadViewController {
    fileprivate func setupUI() {
        self.title = "展开功能列表"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.tableView.register(UINib.init(nibName: "JHHelpTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
    fileprivate func setupData() {
        for _ : NSInteger in 0...self.sentionTitles.count - 1 {
            self.flagArray.add(false)
            
        }
    }
}


extension JHSpreadViewController : UITableViewDelegate, UITableViewDataSource {
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sentionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.flagArray[section] as! Bool {
            return 2
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UINib.init(nibName: "JHHelpTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
        let cell : JHHelpTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JHHelpTableViewCell
        return cell
    }
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : JHHelpSectionHeader = JHHelpSectionHeader.loadHelpSectionView()
        view.tag = section + 2000
        view.callBackBlock = {(index, select) in
            let ratio : NSInteger = index - 2000
            if self.flagArray[ratio] as! Bool {
                self.flagArray[ratio] = false
            } else {
                self.flagArray[ratio] = true
            }
            self.tableView.reloadSections(IndexSet.init(integer: index - 2000), with: UITableViewRowAnimation.automatic)
        }

        view.sectionTitleLabel.text = self.sentionTitles[section]
        return view
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

