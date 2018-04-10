//
//  JHMultiFunctionTableViewController.swift
//  YUBODemo
//
//  Created by cjh on 2018/3/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

class JHMultiFunctionTableViewController: UITableViewController {
    let textArray : [String] = ["展开列表功能", "弹出列表功能", "朋友圈评论点赞布局","3D旋转", "无限轮播图","AutoLayout计算cell高度", "不规则Label", "运行时总结"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELLID")
        self.tableView.tableFooterView = UIView()
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath)
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.text = textArray[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = JHSpreadViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = JHFoldViewController.init()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
           let sb = UIStoryboard.init(name: "JHFriendCircleTableViewController", bundle: nil)
           let vc = sb.instantiateViewController(withIdentifier: "vc")
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = JHTransform3DViewController()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = JHinfinityScrollViewController()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 5 {
            let vc = JHAutoCellHeightTableViewController()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 6 {
            let vc = JHIrregularViewController()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        } else if indexPath.row == 7 {
            let vc = JHRuntimeTableViewController()
            JHJumpVcManager.shareInstance().navigationVc.pushViewController(vc, animated: true)
        }
    }
    
}
