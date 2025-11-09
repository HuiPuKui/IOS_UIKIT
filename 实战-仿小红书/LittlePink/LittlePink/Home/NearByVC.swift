//
//  NearByVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/5.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("NearBy", comment: "首页上方的附近标签"))
    }

}
