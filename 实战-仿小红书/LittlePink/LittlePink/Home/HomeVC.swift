//
//  HomeVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/5.
//

import UIKit
import XLPagerTabStrip

class HomeVC: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        
        // MARK: 设置上方 Bar、按钮、条 UI
        
        // 1. 整体 bar -- 在 sb 上设
        
        // 2. selectedBar -- 按钮下方条
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "main")!
        self.settings.style.selectedBarHeight = 3
        
        // 3. buttonBarItem -- 文本或图片的按钮
        self.settings.style.buttonBarItemBackgroundColor = .clear
        self.settings.style.buttonBarItemTitleColor = .label
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 16)
        self.settings.style.buttonBarItemLeftRightMargin = 0
        
        super.viewDidLoad()
        
        // 4. 禁止边界回弹效果
        self.containerView.bounces = false
        
        // 5. barItem 被选中/不选中时候的效果
        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
        
        // 6. 进入显示第二个页面
        DispatchQueue.main.async {
            self.moveToViewController(at: 1, animated: false)
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = self.storyboard!.instantiateViewController(identifier: kFollowVCID)
        let discoveryVC = self.storyboard!.instantiateViewController(identifier: kDiscoveryVCID)
        let nearByVC = self.storyboard!.instantiateViewController(identifier: kNearByVCID)
        
        return [followVC, discoveryVC, nearByVC]
    }

}
