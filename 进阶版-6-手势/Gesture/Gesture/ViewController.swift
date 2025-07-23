//
//  ViewController.swift
//  Gesture
//
//  Created by 惠蒲葵 on 2025/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var pinchLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var screenEdgePanLabel: UILabel!
    @IBOutlet weak var longPressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: - 添加手势 轻触
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        self.tapLabel.addGestureRecognizer(tap)
        
        // 再添加事件的通用做法
//        tap.addTarget(self, action: #selector(handleTap1(tap:)))
        
        // MARK: - 捏合 缩放
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinch:)))
        self.pinchLabel.addGestureRecognizer(pinch)
        
        // MARK: - 旋转
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(rotation:)))
        self.rotationLabel.addGestureRecognizer(rotation)
        
        // MARK: - 轻扫
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
//        swipe.direction = .right // 方向
//        swipe.numberOfTouchesRequired = 1 // 手指
        self.swipeLabel.addGestureRecognizer(swipe)
        
        // MARK: - 平移 拖拽
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
//        pan.maximumNumberOfTouches = 5 // 最多手指
//        pan.minimumNumberOfTouches = 1 // 最少手指
        self.panLabel.addGestureRecognizer(pan)
        
        // MARK: - 屏幕边缘平移
        let screenEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan(screenEdgePan:)))
        screenEdgePan.edges = .left
        self.view.addGestureRecognizer(screenEdgePan)
        
        // MARK: - 长按
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPress:)))
//        longPress.numberOfTapsRequired = 0 // 长按之前需要轻点 n 下
//        longPress.numberOfTouchesRequired = 1 // 手指数
//        longPress.minimumPressDuration = 0.5 // 至少长按的时间
//        longPress.allowableMovement = 10.0 // 手抖动的范围 单位：Point
        self.longPressLabel.addGestureRecognizer(longPress)
    }

    @IBAction func handleIBTap(IBTap: UITapGestureRecognizer) {
        guard let IBTapLebel = IBTap.view as? UILabel else { return }
        if IBTap.state == .ended {
            IBTapLebel.text = "被翻牌了"
        }
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            self.tapLabel.text = "被翻牌了"
        }
    }
    
    @objc func handleTap1(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            print("xx")
        }
    }
    
    // 持续型手势 - 持续调用这个函数
    @objc func handlePinch(pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began || pinch.state == .changed {
            self.pinchLabel.transform = self.pinchLabel.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1.0
            
            print(pinch.velocity) // 缩放速度（放大为正，缩小为负） 单位：缩放比/秒
        }
    }
    
    // 持续型手势 - 持续调用这个函数
    @objc func handleRotation(rotation: UIRotationGestureRecognizer) {
        if rotation.state == .began || rotation.state == .changed {
            self.rotationLabel.transform = self.rotationLabel.transform.rotated(by: rotation.rotation)
            rotation.rotation = 0.0
            
            print(rotation.velocity) // 旋转速度（顺时针为正，逆时针为负） 单位：弧度/秒
        }
    }
    
    // 离散型手势
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        if swipe.state == .ended {
            self.swipeLabel.text = "被翻牌了"
        }
    }
    
    // 持续型手势 - 持续调用这个函数
    var startCenter: CGPoint = CGPoint.zero
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: self.panLabel.superview)
//        pan.setTranslation(<#T##translation: CGPoint##CGPoint#>, in: <#T##UIView?#>) // 设置手指在某个 view 中的偏移量
//        pan.velocity(in: <#T##UIView?#>) // 设置平移速度 单位：point/秒 （CGPoint，有 x 和 y）
        
        if pan.state == .began {
            self.startCenter = self.panLabel.center
        }
        
        if pan.state != .cancelled {
            self.panLabel.center = CGPoint(x: self.startCenter.x + translation.x, y: self.startCenter.y + translation.y)
        } else {
            self.panLabel.center = self.startCenter
        }
    }
    
    // 持续型手势 - 持续调用这个函数
    @objc func handleScreenEdgePan(screenEdgePan: UIScreenEdgePanGestureRecognizer) {
        let x = screenEdgePan.translation(in: self.view).x
        if screenEdgePan.state == .began || screenEdgePan.state == .changed {
            self.screenEdgePanLabel.transform = CGAffineTransform(translationX: x, y: 0)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.screenEdgePanLabel.transform = .identity
            }
        }
    }
    
    // 持续型手势 - 持续调用这个函数
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            self.view.backgroundColor = .yellow
        }
    }
}

