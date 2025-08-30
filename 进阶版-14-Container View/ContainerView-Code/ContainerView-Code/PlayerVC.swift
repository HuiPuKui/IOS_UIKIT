//
//  PlayerVC.swift
//  ContainerView-Code
//
//  Created by 惠蒲葵 on 2025/8/30.
//

import UIKit
import AVKit

class PlayerVC: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player = AVPlayer(url: Bundle.main.url(forResource: "Warcraft", withExtension: "mp4")!)
        self.player = player
    }
    
}
