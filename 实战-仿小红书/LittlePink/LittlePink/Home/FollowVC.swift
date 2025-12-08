//
//  FollowVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/5.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = ColorButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100), color: .green)
        self.view.addSubview(btn)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: NSLocalizedString("Follow", comment: "首页上方的关注标签"))
    }

}

class ColorButton: UIButton {
    
    var color: UIColor
    
    init(frame: CGRect, color: UIColor) {
        self.color = color
        super.init(frame: frame)
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
