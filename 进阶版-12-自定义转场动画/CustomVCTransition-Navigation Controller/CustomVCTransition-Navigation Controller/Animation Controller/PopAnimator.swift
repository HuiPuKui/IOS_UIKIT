//
//  PopAnimator.swift
//  CustomVCTransition-Navigation Controller
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        // 把 toView 放到 fromView 下面去
        containerView.insertSubview(toView, belowSubview: fromView)
        
        fromView.layer.shadowOpacity = 0.5
        fromView.layer.shadowRadius = 10
        fromView.layer.shadowPath = UIBezierPath(rect: fromView.bounds).cgPath // 设置阴影一定要指定这个，减少渲染成本
        
        toView.transform = CGAffineTransform(translationX: -containerView.frame.width / 3, y: 0)
        toView.alpha = 1
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromView.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
            fromView.alpha = 1
            toView.transform = .identity
            toView.alpha = 1
        } completion: { _ in
            fromView.transform = .identity
            toView.transform = .identity
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
