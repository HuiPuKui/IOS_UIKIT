//
//  PanInteraction.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/18.
//

import UIKit

class PanInteraction: UIPercentDrivenInteractiveTransition {

    let detailVC: DetailViewController
    var isInteractive = false
    
    init(detailVC: DetailViewController) {
        self.detailVC = detailVC
        super.init()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        self.detailVC.view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        
        let progress = pan.translation(in: pan.view).x / 200
        switch pan.state {
        case .began:
            self.isInteractive = true
            self.detailVC.dismiss(animated: true, completion: nil)
        case .changed:
            update(progress)
        case .cancelled, .ended:
            self.isInteractive = false
            if progress > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
        
    }
    
}
