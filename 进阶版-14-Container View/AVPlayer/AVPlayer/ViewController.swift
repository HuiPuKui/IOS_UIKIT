//
//  ViewController.swift
//  AVPlayer
//
//  Created by 惠蒲葵 on 2025/8/27.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        let player = AVPlayer(url: Bundle.main.url(forResource: "Warcraft", withExtension: ".mp4")!)
        
//        // 单纯用 AVPlayer 的话有更高的定制性
//        // 显示视频 -- 不然只有声音
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.videoView.bounds // 这个可能不准，最好在 viewDidLayoutSubviews 再次赋值
//        self.videoView.layer.addSublayer(playerLayer)
//        
//        // 比如用某些按钮控制
//        player.play()
//        player.pause()
//        player.rate // 设定播放速度
//        player.replaceCurrentItem(with: AVPlayerItem?) // 更换视频
         
        // 用 AVPlayerViewController 可以显示系统自带的各种控件(播放，暂停，快进快退等)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        addChild(playerVC)
        playerVC.view.frame = self.videoView.bounds
        self.videoView.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "我是一条评论"
        return cell
    }
    
}
