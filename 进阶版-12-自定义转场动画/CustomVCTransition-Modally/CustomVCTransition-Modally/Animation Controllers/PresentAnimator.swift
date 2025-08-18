//
//  PresentAnimator.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/17.
//

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        
//        let fromVC = transitionContext.viewController(forKey: .from)
//        let toVC = transitionContext.viewController(forKey: .to)
        
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
//        transitionContext.initialFrame(for: <#T##UIViewController#>)
//        transitionContext.finalFrame(for: <#T##UIViewController#>)
        
        // 把视图移到右侧，并透明
        toView.alpha = 0
        toView.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            // 透明并到左侧
            fromView.alpha = 0
            fromView.transform = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
            // 不透明并回到本来的位置
            toView.alpha = 1
            toView.transform = .identity
        } completion: { _ in
            fromView.transform = .identity
            toView.transform = .identity
            // 告诉结束了，否则会卡住
            transitionContext.completeTransition(true)
        }

    }

}
