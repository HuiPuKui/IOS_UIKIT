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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        if let user = self.user {
            if self.isMyNote {
                self.getMyNote(user)
            } else if self.isMyFav {
                
            } else {
                
            }
        } else if self.isDraft {
            getDraftNotes()
        } else {
            getNotes()
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
