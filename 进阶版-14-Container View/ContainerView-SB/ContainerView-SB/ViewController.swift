//
//  ViewController.swift
//  ContainerView-SB
//
//  Created by 惠蒲葵 on 2025/8/30.
//

import UIKit

class ViewController: UIViewController {

    var playerVC: PlayerVC!
    var tableVC: TableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 第一种方式获取
//        self.playerVC = (storyboard!.instantiateViewController(withIdentifier: "playerVC") as! PlayerVC)
//        self.tableVC = (storyboard!.instantiateViewController(withIdentifier: "tableVC") as! TableVC)
        print("父视图控制器")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 第二种方式获取
//        // 上下同理
//        if segue.identifier == "seguePlayerVC" {
//            self.playerVC = (segue.destination as! PlayerVC)
//        } else if segue.identifier == "segueTableVC" {
//            self.tableVC = (segue.destination as! TableVC)
//        }
        
        if let vc = segue.destination as? PlayerVC {
            self.playerVC = vc
        }
        
        if let vc = segue.destination as? TableVC {
            self.tableVC = vc
        }
    }

}

