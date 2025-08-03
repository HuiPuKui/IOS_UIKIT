//
//  ViewController.swift
//  ScrollView
//
//  Created by 惠蒲葵 on 2025/7/28.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        self.scrollView.contentInsetAdjustmentBehavior = .never
        // 在这里获取 frame / bounds 是不准的
    }
    
    // 根据 约束布局之后 / 横竖屏切换之后 调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 计算最小缩放比例
        let scaleFactor = self.scrollView.frame.width / self.imageView.bounds.width
        
        // 最小/大缩放因子: 最小/大可以缩小/放大到原视图的多少倍（必须先设置这个 再设置当前缩放比例）
        self.scrollView.minimumZoomScale = scaleFactor
        self.scrollView.maximumZoomScale = 1
        
        // 缩小/放大的反弹效果
        self.scrollView.bouncesZoom = true
        // 滚动的反弹效果
        self.scrollView.bouncesVertically = true
        self.scrollView.bouncesHorizontally = true
        // 拖动滚动视图时键盘收起
        self.scrollView.keyboardDismissMode = .onDrag
        
        // 设置最开始缩放比例为 最小，不能小于最小，不能大于最大
        self.scrollView.zoomScale = scaleFactor // 不带动画
//        self.scrollView.setZoomScale(scaleFactor, animated: true) // 带动画
        
//        self.scrollView.contentOffset = CGPoint(x: 100, y: 100)
        
        // 如果 View 使用代码创建 默认是 true，如果是 storyboard 默认是 false
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        
    }

    // 指定哪个视图可以被缩放（必须指定，否则内容视图无法被缩放）
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.imageView
    }
    
    // 设置 ZoomScale 或用户对内容进行缩放时会调用
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetY: CGFloat = (self.scrollView.frame.height - self.imageView.frame.height) / 2
        self.imageView.center = CGPoint(x: self.imageView.frame.width / 2, y: self.imageView.frame.height / 2 + offsetY)
    }
}

