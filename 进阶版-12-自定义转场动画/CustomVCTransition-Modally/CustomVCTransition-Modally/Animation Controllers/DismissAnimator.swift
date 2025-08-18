//
//  DismissAnimator.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        toView.alpha = 0
        toView.transform = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromView.alpha = 0
            fromView.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
            
            toView.alpha = 1
            toView.transform = .identity
        } completion: { _ in
            fromView.transform = .identity
            toView.transform = .identity
            
            transitionContext.completeTransition(true)
        }
    }
    
}
