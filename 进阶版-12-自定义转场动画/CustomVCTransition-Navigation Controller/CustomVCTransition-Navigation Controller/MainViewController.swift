//
//  MainViewController.swift
//  CustomVCTransition-Navigation Controller
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
    }


}

extension MainViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return nil
    }
    
}

