//
//  DetailViewController.swift
//  CustomVCTransition-Modally
//
//  Created by 惠蒲葵 on 2025/8/17.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        detailImageView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            dismiss(animated: true, completion: nil)
        }
    }

}
