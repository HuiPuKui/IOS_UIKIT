//
//  PushAnimator.swift
//  CustomVCTransition-Navigation Controller
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        containerView.addSubview(toView)
        
        toView.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        toView.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromView.transform = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
            fromView.alpha = 0
            toView.transform = .identity
            toView.alpha = 1
        } completion: { _ in
            fromView.transform = .identity
            toView.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
