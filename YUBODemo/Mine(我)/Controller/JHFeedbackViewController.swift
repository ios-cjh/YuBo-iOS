//
//  JHFeedbackViewController.swift
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/17.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit
import MBProgressHUD

class JHFeedbackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
	
        self.view.backgroundColor = UIColor.yellow
        setupUI()
    }
}

/// MARK - 设置UI内容
extension JHFeedbackViewController {
    fileprivate func setupUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.gray
        // 设置导航栏
        setupNav()
        
        // 设置输入框
        setupTextView()
        
        // 设置发送按钮
        setupSendBtn()
    }
	
	
    // 设置发送按钮
    fileprivate func setupSendBtn() {
		let width = UIScreen.main.bounds.size.width
        let sendBtn = UIButton()
		sendBtn.layer.cornerRadius = 5
		sendBtn.layer.masksToBounds = true
		sendBtn.frame = CGRect(x: (width - width * 0.8) / 2, y: 300, width: width * 0.8, height: 40)
		sendBtn.backgroundColor = UIColor.init(red: 153 / 255.0, green: 214 / 255.0, blue: 93 / 255.0, alpha: 1.0)
		sendBtn.setTitle("发送", for: .normal)
		sendBtn.setTitleColor(UIColor.white, for: .normal)
		sendBtn.addTarget(self, action: #selector(senfBtnClick(_:)), for: .touchUpInside)
		self.view.addSubview(sendBtn)
    } //153 214 93
	
    // 设置输入框
    fileprivate func setupTextView() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let textView = UITextView()
        textView.backgroundColor = UIColor.cyan
		textView.delegate = self
        // 记得适配iPhone X
		
        textView.frame = CGRect(x: 0, y: 64, width:width , height: height * 0.3)
		textView.becomeFirstResponder()
		textView.returnKeyType = UIReturnKeyType.send
        textView.backgroundColor = UIColor.white
		textView.tintColor = UIColor.init(red: 153 / 255.0, green: 214 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        self.view.addSubview(textView)
		
	}
    
    // 设置导航栏
    fileprivate func setupNav() {
        let serverBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        serverBtn.setTitle("客服", for: .normal)//153 214 93
		serverBtn.setTitleColor(UIColor.white, for: .normal)
        let serverItem = UIBarButtonItem (customView: serverBtn)
        self.navigationItem.rightBarButtonItem = serverItem
        
        let cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        cancelBtn.addTarget(self, action: #selector(cannelBtnClick(_:)), for: .touchUpInside)
        cancelBtn.setTitle("取消", for: .normal)
		cancelBtn.setTitleColor(UIColor.white, for: .normal)
        let cannelItem = UIBarButtonItem (customView: cancelBtn)
        self.navigationItem.leftBarButtonItem = cannelItem
    }
}

/// MARK - 事件处理
extension JHFeedbackViewController {
    @objc fileprivate func cannelBtnClick (_ btn : UIButton) {
		self.navigationController?.popToRootViewController(animated: true)
    }
	
	@objc fileprivate func senfBtnClick(_ btn : UIButton) {
		let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
		hud.label.text = "已经发送!!^_^"
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
			hud.hide(animated: true)
			self.navigationController?.popToRootViewController(animated: true)
		}
	}
}

/// MARK - 成为 UITextView的代理， 实现协议的方法
extension JHFeedbackViewController : UITextViewDelegate{
	func textViewDidBeginEditing(_ textView: UITextView) {
		print("textViewDidBeginEditing")
	}
	func textViewDidEndEditing(_ textView: UITextView) {
		print("textViewDidEndEditing")
	}
	func textViewDidChangeSelection(_ textView: UITextView) {
		print("textViewDidChangeSelection")
	}
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		/**
		let string = "abc"
		var count = string.characters.count
		// 第二行报错
		'characters' is deprecated: Please use String or Substring directly
		// 对应新方法
		count = string.count
		*/
		print("text = \(textView.text) length = \(textView.text.count)")
		
		if text == "\n" {
//			self.view.endEditing(true)
			textView.resignFirstResponder()
			return true
		}
		
		return true
	}
}


