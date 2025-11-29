//
//  ChannelVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/29.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {

    var PVDelegate: ChannelVCDelegate?
    
    override func viewDidLoad() {
        // 1. selectedBar -- 按钮下方条
        self.settings.style.selectedBarHeight = 2
        self.settings.style.selectedBarBackgroundColor = mainColor
        
        // 2. buttonBarItem -- 文本或图片的按钮
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        
        super.viewDidLoad()

        // 3. 禁止边界回弹效果
        self.containerView.bounces = false
        
        // 4. barItem 被选中/不选中时候的效果
        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs: [UIViewController] = []
        
        for i in kChannels.indices {
            let vc = self.storyboard?.instantiateViewController(identifier: kChannelTableVCID) as! ChannelTableVC
            vc.channel = kChannels[i]
            vc.subChannels = kAllSubChannels[i]
            vcs.append(vc)
        }
        
        return vcs
    }

}
