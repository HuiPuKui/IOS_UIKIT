//
//  ChannelTableVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/29.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {

    var channel: String = ""
    var subChannels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subChannels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)

        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelVC = parent as! ChannelVC
        channelVC.PVDelegate?.updateChannel(channel: self.channel, subChannel: self.subChannels[indexPath.row])
        
        // print(self.presentingViewController)
        // 根据 present 及 dismiss 机制，子视图控制器的 presentingViewController 和父视图控制器一样(这里为 NoteEditVC)
        // 故这里用 dismiss 就等于是在父视图控制器中直接用 dismiss
        self.dismiss(animated: true)
    }
    
}

extension ChannelTableVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: self.channel)
    }
    
}
