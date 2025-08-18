//
//  TabBarController.swift
//  TabBarController
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

enum Operation {
    case toRight, toLeft
}

class TabBarController: UITabBarController {
    
    var customInteraction: CustomInteraction!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.customInteraction = CustomInteraction(tabBarVC: self)
        self.delegate = self
    }

}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        let fromIndex = tabBarController.viewControllers!.firstIndex(of: fromVC)!
        let toIndex = tabBarController.viewControllers!.firstIndex(of: toVC)!
        
        let operation: Operation = toIndex > fromIndex ? .toRight : .toLeft
        return CustomAnimator(operation: operation)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return self.customInteraction.isInteractive ? self.customInteraction : nil
    }
    
}
