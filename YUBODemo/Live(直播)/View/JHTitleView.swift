//
//  JHTitleView.swift
//  YUBODemo
//
//  Created by cjh on 2018/1/24.
//  Copyright © 2018年 cjh. All rights reserved.
//

import UIKit

protocol JHTitleViewDelegate : class {
    func titleView(_ titleView : JHTitleView, electedIndex index : Int)
}



class JHTitleView: UIView {
    
    // 对外属性
    weak var delegate : JHTitleViewDelegate?
    
    // 定义属性
    fileprivate var titles : [String]!
    fileprivate var style : JHTitleStyle!
    fileprivate var currentIndex : Int = 0
    
    // 定义存储属性
    fileprivate lazy var titleLabelArray : [UILabel] = [UILabel]()
    
    // MARK:- 懒加载属性控件
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = self.bounds
        scrollV.showsVerticalScrollIndicator = false
        scrollV.scrollsToTop = false
        return scrollV
    }()
    
    fileprivate lazy var separateView : UIView = {
        let separateV = UIView()
        separateV.backgroundColor = UIColor.magenta
        let h : CGFloat = 0.5
        separateV.frame = CGRect (x: 0, y: self.frame.height - h, width: self.frame.width, height: h)
        return separateV
    }()
    
    fileprivate lazy var coverView : UIView = {
        let coverView = UIView()
        coverView.backgroundColor = self.style.coverBgColor
        coverView.alpha = 0.7
        return coverView
    }()
    
    // MARK:- 计算属性
    fileprivate lazy var normalColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(self.style.normalColor)
    
    fileprivate lazy var selectedColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(self.style.selectedColor)

    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String], style : JHTitleStyle) {
        super.init(frame: frame)
        self.titles = titles
        self.style = style
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JHTitleView {
    fileprivate func setupUI() {
        // 添加Scrollview
        self.addSubview(scrollView)
        
        // 添加底部分割线
        self.addSubview(separateView)
        
        // 设置所有的标题label 并计算label位置
        setupTitleLabels()
        setupTitleLabelPosition()
        
        // 设置遮盖的view
        if style.isShowCover {
            setupCoverView()
        }
        
    }
    
    fileprivate func setupTitleLabels() {
        // 遍历所有的标题 并将label添加到scrollview上
        for (index , title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.tag = index
            titleLabel.text = title
            titleLabel.textColor = index == 0 ? style.selectedColor : style.normalColor
            titleLabel.font = style.font
            titleLabel.textAlignment = .center
            titleLabel.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer (target: self, action: #selector(titleLabelClick(_ :)))
            titleLabel.addGestureRecognizer(tapGes)
            
            
            scrollView.addSubview(titleLabel)
            titleLabelArray.append(titleLabel)
        }
    }
    
    fileprivate func setupTitleLabelPosition() {
        var titleX: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        let titleH : CGFloat = frame.height
        
         let count = titles.count
        
        // 遍历数组里存放的label
        for (index, Label) in titleLabelArray.enumerated() {
            if style.isScrollEnable { // 能滚动
                let rect = (Label.text! as NSString).boundingRect(with: CGSize(width : CGFloat(MAXFLOAT),height:0.0), options:.usesLineFragmentOrigin, attributes: [NSFontAttributeName : style.font], context: nil)
                titleW = rect.width
                
                if  index == 0 {
                    titleX = style.titleMargin * 0.5

                } else {
                    let preLabel = titleLabelArray[index - 1] // 上一个的label
                    titleX = preLabel.frame.maxX + style.titleMargin
                }
                
            } else { // 不能滚动
                titleW = self.frame.width / CGFloat(count)
                titleX = titleW * CGFloat(index)
            }
            Label.frame = CGRect (x: titleX, y: titleY, width: titleW, height: titleH)
        }
        
        if style.isScrollEnable {
            scrollView.contentSize = CGSize (width: titleLabelArray.last!.frame.maxX + style.titleMargin * 0.5, height: 0)
        }
    }
    
    fileprivate func setupCoverView() {
        scrollView.insertSubview(coverView, at: 0)
        let firstLabel = titleLabelArray[0]
        let coverW = firstLabel.frame.width
        let coverH = style.coverH
        let coverX = firstLabel.frame.origin.x
        let coverY = (self.bounds.height - coverH) * 0.5
        coverView.frame = CGRect (x: coverX, y: coverY, width: coverW, height: coverH)
        
        coverView.layer.cornerRadius = style.coverRadius
        coverView.layer.masksToBounds = true
        
    }
}


extension JHTitleView {
    @objc fileprivate func titleLabelClick(_ tap : UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        
        if currentLabel.tag == currentIndex { // 点击同一个label
            return
        }
        
        // 取出之前点击的label
        let oldLabel = titleLabelArray[currentIndex]
        
        currentLabel.textColor = style.selectedColor
        oldLabel.textColor = style.normalColor
        
        
        // 保存最新的当前下标指
        currentIndex = currentLabel.tag
        
        // 通知代理
        delegate?.titleView(self, electedIndex: currentIndex)
        
        // 根据scrollView的偏移量， 让label居中显示
        contentViewDidEndScroll()
        
        
        // 遮盖移动
        if style.isShowCover {
            
            let coverX = style.isScrollEnable ? (currentLabel.frame.origin.x - style.coverMargin) : currentLabel.frame.origin.x
            let coverW = style.isScrollEnable ? (currentLabel.frame.size.width + style.coverMargin * 2) : currentLabel.frame.size.width
            
            UIView.animate(withDuration: 0.15, animations: {
                self.coverView.frame.origin.x = coverX
                self.coverView.frame.size.width = coverW
            })
        }
    }
}

// MARK:- 获取RGB的值
extension JHTitleView {
    fileprivate func getRGBWithColor(_ color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard let components = color.cgColor.components else {
            fatalError("请使用RGB方式给Title赋值颜色")
        }
        
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}


// MARK:- 对外暴露的方法
extension JHTitleView {
    
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        let sourceLabel = titleLabelArray[sourceIndex]
        let targetLabel = titleLabelArray[targetIndex]
        
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (selectedColorRGB.0 - normalColorRGB.0, selectedColorRGB.1 - normalColorRGB.1, selectedColorRGB.2 - normalColorRGB.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: selectedColorRGB.0 - colorDelta.0 * progress, g: selectedColorRGB.1 - colorDelta.1 * progress, b: selectedColorRGB.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: normalColorRGB.0 + colorDelta.0 * progress, g: normalColorRGB.1 + colorDelta.1 * progress, b: normalColorRGB.2 + colorDelta.2 * progress)
        
        
        // 保存最新的值
        currentIndex = targetIndex
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveTotalW = targetLabel.frame.width - sourceLabel.frame.width

        if style.isNeedScale {
            let scaleDelta = (style.scaleRange - 1.0) * progress
            sourceLabel.transform = CGAffineTransform(scaleX: style.scaleRange - scaleDelta, y: style.scaleRange - scaleDelta)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + scaleDelta, y: 1.0 + scaleDelta)
        }
        
        
        if style.isShowCover {
            coverView.frame.size.width = style.isScrollEnable ? (sourceLabel.frame.width + 2 * style.coverMargin + moveTotalW * progress) : (sourceLabel.frame.width + moveTotalW * progress)
            coverView.frame.origin.x = style.isScrollEnable ? (sourceLabel.frame.origin.x - style.coverMargin + moveTotalX * progress) : (sourceLabel.frame.origin.x + moveTotalX * progress)
        }

    }
    
    func contentViewDidEndScroll() {
        // 如果不能滚动，则不需要调整label的中间位置
        guard style.isScrollEnable  else {
            return
        }

        // 获取将要选中的label
        let targetLabel = titleLabelArray[currentIndex]

        var offSetX = targetLabel.center.x - self.bounds.size.width * 0.5
        print("偏移量 = \(offSetX)")

        if offSetX < 0 {
            offSetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - self.bounds.size.width
        
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        scrollView.setContentOffset(CGPoint(x :offSetX, y:0), animated: true)
    }
}






