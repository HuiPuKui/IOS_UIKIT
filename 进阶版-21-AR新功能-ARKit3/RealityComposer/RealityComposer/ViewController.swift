//
//  ViewController.swift
//  RealityComposer
//
//  Created by 刘军 on 2020/3/30.
//  Copyright © 2020 Lebus. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    var robotWalk: AR.RobotWalk!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotWalk = try! AR.loadRobotWalk()
        arView.scene.addAnchor(robotWalk)
    }
    @IBAction func walk(_ sender: Any) {
        
        robotWalk.notifications.walkStart.post()
        
    }
}
