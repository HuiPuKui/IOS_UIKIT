//
//  CustomAnimator.swift
//  TabBarController
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let operation: Operation
    
    init(operation: Operation) {
        self.operation = operation
        super.init()
    }
    
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
        
        let offset = containerView.frame.width
        toView.frame.origin.x = self.operation == .toRight ? offset : -offset
        toView.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fromView.frame.origin.x = self.operation == .toRight ? -offset : offset
            fromView.alpha = 0
            
            toView.frame.origin.x = 0
            toView.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
