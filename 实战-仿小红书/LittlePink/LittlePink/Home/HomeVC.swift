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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let followVC = self.storyboard!.instantiateViewController(identifier: kFollowVCID)
        let discoveryVC = self.storyboard!.instantiateViewController(identifier: kDiscoveryVCID)
        let nearByVC = self.storyboard!.instantiateViewController(identifier: kNearByVCID)
        
        return [followVC, discoveryVC, nearByVC]
    }

}
