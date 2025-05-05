//
//  ViewController.swift
//  Dice
//
//  Created by HuiPuKui on 2025/5/4.
//

import UIKit

class ViewController: UIViewController {

    let diceArray: [String] = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var index1: Int = 0
    var index2: Int = 0
    
    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.updateDiceImages()
    }
    
    /**
     * 摇晃手机结束的回调
     */
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.updateDiceImages()
    }

    @IBAction func roll(_ sender: Any) {
        self.updateDiceImages()
    }
    
    func updateDiceImages() -> Void {
        self.index1 = Int.random(in: 0...5)
        self.index2 = Int.random(in: 0...5)
        
        self.diceImageView1.image = UIImage(named: self.diceArray[self.index1])
        self.diceImageView2.image = UIImage(named: self.diceArray[self.index2])
    }
    
}
