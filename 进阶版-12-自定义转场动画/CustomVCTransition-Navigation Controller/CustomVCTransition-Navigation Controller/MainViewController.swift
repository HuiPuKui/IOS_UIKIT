//
//  MainViewController.swift
//  CustomVCTransition-Navigation Controller
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class MainViewController: UIViewController {

    var panInteraction: PanInteraction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            self.panInteraction = PanInteraction(detailVC: detailVC)
        }
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
        guard
            let panInteraction = self.panInteraction,
                panInteraction.isInteraction
        else {
            return nil
        }
        return panInteraction
    }
    
}

