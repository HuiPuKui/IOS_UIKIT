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
        present(detailVC, animated: true, completion: nil)
    }
}

