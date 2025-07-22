//
//  ViewController.swift
//  CGAffineTransform
//
//  Created by 惠蒲葵 on 2025/7/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CGFloat.pi = 180度
        
        // 旋转
        // 1度
        let oneDegree = CGFloat.pi / 180
//        self.imageView.transform = CGAffineTransform(rotationAngle: 90 * oneDegree)
        
        // 缩放
//        self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        // 平移
//        self.imageView.transform = CGAffineTransform(translationX: 100, y: 100)
        
        // 在自己的基础上放大 3 倍
//        self.imageView.transform = self.imageView.transform.scaledBy(x: 3, y: 3)
        
        // 没有附加任何 transform 的状态下操作
//        self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 3, y: 3)
        
        // 追加效果, 添加动画
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn) {
            self.imageView.transform = CGAffineTransform(translationX: 100, y: 100).scaledBy(x: 2, y: 2).rotated(by: 90 * oneDegree)
        }
        
    }


}

