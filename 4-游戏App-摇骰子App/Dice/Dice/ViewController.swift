//
//  ViewController.swift
//  Dice
//
//  Created by HuiPuKui on 2025/5/4.
//

import UIKit

class ViewController: UIViewController {

    var index1: Int = 0
    var index2: Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func roll(_ sender: Any) {
        
        index1 = Int.random(in: 1...6)
        index2 = Int.random(in: 1...6)
        
        diceImageView1.image = UIImage(named: "dice\(index1)")
        diceImageView2.image = UIImage(named: "dice\(index2)")
        
    }
    
}

