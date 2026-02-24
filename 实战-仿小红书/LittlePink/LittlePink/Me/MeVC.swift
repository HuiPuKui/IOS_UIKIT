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
    
    var isFromNote: Bool = false
    var isMySelf: Bool = false
    
    init?(coder: NSCoder, user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        self.setUI()
    }
    
    override var bouncesType: BouncesType { .child }
    
    override func segementSlideHeaderView() -> UIView? {
        return setHeaderView()
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
        let isMyDraft = (index == 0)
                        && self.isMySelf
                        && (UserDefaults.standard.integer(forKey: kDraftNoteCount) > 0)
        
        let vc = self.storyboard!.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        vc.isMyDraft = isMyDraft
        vc.user = self.user
        vc.isMyNote = index == 0
        vc.isMyFav = index == 1
        vc.isMyselfLike = (self.isMySelf && index == 2)
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
