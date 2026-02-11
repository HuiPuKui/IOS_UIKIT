//
//  MeVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import UIKit
import LeanCloud
import SegementSlide

class MeVC: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 去掉返回按钮文字
        self.navigationItem.backButtonDisplayMode = .minimal
        self.setUI()
        
        self.defaultSelectedIndex = 0
        self.reloadData()
    }
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = mainColor
        headerView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 4).isActive = true
        return headerView
    }
    
    override var titlesInSwitcher: [String] {
        return ["笔记", "收藏", "赞过"]
    }
    
    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        var config = super.switcherConfig
        config.type = .tab
        config.selectedTitleColor = .label
        config.indicatorColor = mainColor
        return config
    }
    
    override func segementSlideContentViewController(at index: Int) -> (any SegementSlideContentScrollViewDelegate)? {
        let vc = self.storyboard!.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        return vc
    }

//    @IBAction func logoutTest(_ sender: Any) {
//        LCUser.logOut()
//        
//        let loginVC = self.storyboard!.instantiateViewController(identifier: kLoginVCID)
//        
//        loginAndMeParentVC.removeChildren()
//        loginAndMeParentVC.add(child: loginVC)
//    }
//
//    @IBAction func showDraftNotes(_ sender: Any) {
//        let navi = self.storyboard!.instantiateViewController(identifier: kDraftNotesNaviID)
//        navi.modalPresentationStyle = .fullScreen
//        self.present(navi, animated: true)
//    }
    
}
