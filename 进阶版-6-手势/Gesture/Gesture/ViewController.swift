//
//  ViewController.swift
//  Gesture
//
//  Created by 惠蒲葵 on 2025/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var pinchLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var screenEdgePanLabel: UILabel!
    @IBOutlet weak var longPressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        tapLabel.addGestureRecognizer(tap)
        
        // 再添加事件的通用做法
//        tap.addTarget(self, action: #selector(handleTap1(tap:)))
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinch:)))
        self.pinchLabel.addGestureRecognizer(pinch)
    }

    @IBAction func handleIBTap(IBTap: UITapGestureRecognizer) {
        guard let IBTapLebel = IBTap.view as? UILabel else { return }
        if IBTap.state == .ended {
            IBTapLebel.text = "被翻牌了"
        }
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            tapLabel.text = "被翻牌了"
        }
    }
    
    @objc func handleTap1(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            print("xx")
        }
    }
    
    @objc func handlePinch(pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began || pinch.state == .changed {
            self.pinchLabel.transform = self.pinchLabel.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1
        }
    }
}

