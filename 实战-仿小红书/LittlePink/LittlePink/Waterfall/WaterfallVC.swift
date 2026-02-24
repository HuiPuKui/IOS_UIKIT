//
//  WaterfallVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/8.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip
import LeanCloud
import SegementSlide

class WaterfallVC: UICollectionViewController, SegementSlideContentScrollViewDelegate {
    
    var channel = ""
    lazy var header = MJRefreshNormalHeader()
    
    @objc var scrollView: UIScrollView { return self.collectionView }
    
    // 草稿页相关数据
    var isDraft = false
    var draftNotes: [DraftNote] = []
    
    // 首页相关数据
    var notes: [LCObject] = []
    
    var isMyDraft: Bool = false
    
    var user: LCUser?
    var isMyNote: Bool = false
    var isMyFav: Bool = false
    var isMyselfLike: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        if let _ = self.user {
            if self.isMyNote {
                self.header.setRefreshingTarget(self, refreshingAction: #selector(getMyNotes))
            } else if self.isMyFav {
                self.header.setRefreshingTarget(self, refreshingAction: #selector(getMyFavNotes))
            } else {
                self.header.setRefreshingTarget(self, refreshingAction: #selector(getMyLikeNotes))
            }
            
            self.header.beginRefreshing()
        } else if self.isDraft {
            getDraftNotes()
        } else {
            self.header.setRefreshingTarget(self, refreshingAction: #selector(getNotes))
            self.header.beginRefreshing()
        }
    }

    @IBAction func dismissDraftNotesVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - IndicatorInfoProvider

extension WaterfallVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: self.channel)
    }
    
}
