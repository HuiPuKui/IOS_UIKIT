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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.getNotes()
        self.getDraftNotes()
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
