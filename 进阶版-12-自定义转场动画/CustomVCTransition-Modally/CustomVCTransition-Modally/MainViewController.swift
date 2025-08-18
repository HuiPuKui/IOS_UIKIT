//
//  MainViewController.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/17.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showDetail(_ sender: Any) {
        let detailVC: DetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .fullScreen // 一定要加这个！！否则会因为非全屏展示方式导致卡住
        present(detailVC, animated: true, completion: nil)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return PresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return nil
    }
    
}
