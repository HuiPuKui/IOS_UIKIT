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
        <#code#>
    }

}
