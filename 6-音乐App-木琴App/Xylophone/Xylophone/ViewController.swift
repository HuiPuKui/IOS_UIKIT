//
//  ViewController.swift
//  Xylophone
//
//  Created by HuiPuKui on 2025/05/06.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let sounds: [String] = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]
    let soundFileExtension: String = "wav"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func play(_ sender: UIButton) {
        self.play(sender.tag)
    }
    
    func play(_ tag: Int) -> Void {
        let url: URL? = Bundle.main.url(forResource: self.sounds[tag - 1], withExtension: self.soundFileExtension)
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url!)
            self.player.play()
        } catch {
            print(error)
        }
    }
}

