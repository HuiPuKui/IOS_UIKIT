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
    
    var user: LCUser
    
    init?(coder: NSCoder, user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 去掉返回按钮文字
        self.navigationItem.backButtonDisplayMode = .minimal
        self.setUI()
        
        self.defaultSelectedIndex = 0
        self.reloadData()
    }
    
    override var bouncesType: BouncesType { .child }
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)
        headerView.user = self.user
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: headerView.rootStackView.frame.height + 16).isActive = true
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
