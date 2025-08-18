//
//  CustomInteraction.swift
//  TabBarController
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class CustomInteraction: UIPercentDrivenInteractiveTransition {
    
    let tabBarVC: TabBarController
    var isInteractive: Bool = false
    
    init(tabBarVC: TabBarController) {
        self.tabBarVC = tabBarVC
        super.init()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        self.tabBarVC.view?.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let translationX = pan.translation(in: pan.view).x
        let progress = abs(translationX / 200)
        
        switch pan.state {
        case .began:
            self.isInteractive = true
            if translationX < 0 {
                // 左滑
                if self.tabBarVC.selectedIndex <= self.tabBarVC.viewControllers!.count - 2 {
                    self.tabBarVC.selectedIndex += 1
                }
            } else {
                // 右滑
                if self.tabBarVC.selectedIndex >= 1 {
                    self.tabBarVC.selectedIndex -= 1
                }
            }
        case .changed:
            update(progress)
        case .cancelled, .ended:
            self.isInteractive = false
            if progress > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
