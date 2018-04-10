//
//  JHRoomLiveViewController.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/27.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit
import IJKMediaFramework

private let kChatToolsViewH : CGFloat = 44



class JHRoomLiveViewController: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var onlineNumberLabel: UILabel!
    
    
    // MARK:- 懒加载属性
    fileprivate lazy var chatToolsView : JHChatToolsView = JHChatToolsView.loadChatToolsView()
    fileprivate lazy var roomVM : JHRoomViewModel = JHRoomViewModel()
    
    fileprivate var player : IJKFFMoviePlayerController?
    
    // mark:- 定义属性 对外暴露模型接口
    var anchorModel : JHAnchorDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .all
        setupUI()
        setupAnchorInfo()
        loadRoomInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.player?.shutdown() // 退出时 记得关闭播放器。
    }
    
    deinit { // 销毁键盘通知
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- 设置UI界面
extension JHRoomLiveViewController {
    fileprivate func setupUI() {
        // 高斯模糊 ios7 UIToolbar  第三方LBBlurredImage
        setupBlurView()
        setupBottomView()
        
        
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect (style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = backgroundImg.bounds
        backgroundImg.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        chatToolsView.frame = CGRect (x: 0, y:kScreenH, width: kScreenW, height:kChatToolsViewH)
        chatToolsView.backgroundColor = UIColor.yellow
        self.view.addSubview(chatToolsView)
    }
}

// MARK:- 设置内容
extension JHRoomLiveViewController {
    fileprivate func setupAnchorInfo() {
        self.backgroundImg.setImage(anchorModel?.pic74)
        self.iconImageView.setImage(anchorModel?.pic51)
        self.roomNumberLabel.text = "\(anchorModel?.roomid ?? 0)"
        self.onlineNumberLabel.text = "\(anchorModel?.focus ?? 0)"
    }
}

// MARK:- 加载房间信息
extension JHRoomLiveViewController {
    fileprivate func loadRoomInfo() {
        if let roomid = anchorModel?.roomid, let uid = anchorModel?.uid {
            self.roomVM.loadLiveURL(roomid, uid, {
                
                // 关闭打印
                IJKFFMoviePlayerController.setLogReport(false)
                
                let url = URL (string: self.roomVM.liveURL)
                
                // 直播 = 手机直播+电脑直播
                if self.anchorModel?.push == 1 {
                    self.player?.view.frame = CGRect (x: 0, y: 150, width: kScreenW, height: kScreenW * 3 / 4)
                } else {
                    self.player?.view.frame = self.view.bounds
                }
                
                
                self.player = IJKFFMoviePlayerController (contentURL: url, with: nil)
                
                self.backgroundImg.insertSubview((self.player?.view)!, at: 1)
                
                DispatchQueue.global().async {
                    self.player?.prepareToPlay()
                    self.player?.play()
                }
            })
        }
    }
}

// MARK:- 事件处理
extension JHRoomLiveViewController {
    @IBAction func closeBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 先让键盘躺下
        UIView.animate(withDuration: 0.25, animations: {
            self.chatToolsView.frame.origin.y = kScreenH
        })
    }
    
    @IBAction func chatItemClick(_ sender: UIButton) {
        self.chatToolsView.inputTextField.becomeFirstResponder()
    }

    
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewH
        UIView.animate(withDuration: duration, animations: {
            self.chatToolsView.frame.origin.y = inputViewY
        })
    }
}


