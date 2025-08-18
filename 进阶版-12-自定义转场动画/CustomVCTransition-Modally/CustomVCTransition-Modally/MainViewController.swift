//
//  MainViewController.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/17.
//

import UIKit

class MainViewController: UIViewController {
    
    var panInteraction: PanInteraction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showDetail(_ sender: Any) {
        let detailVC: DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .fullScreen // 一定要加这个！！否则会因为非全屏展示方式导致卡住
        
        self.panInteraction = PanInteraction(detailVC: detailVC)
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    // 非交互动画 -- 视觉动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return PresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return DismissAnimator()
    }
    
    // 交互动画 -- 主要是手势交互
    func interactionControllerForDismissal(using animator: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return self.panInteraction.isInteractive ? self.panInteraction : nil
    }
    
}
