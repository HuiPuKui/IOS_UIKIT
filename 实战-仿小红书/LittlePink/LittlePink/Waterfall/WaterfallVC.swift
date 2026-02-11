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
    var isMyDraft = false
    var draftNotes: [DraftNote] = []
    
    // 首页相关数据
    var notes: [LCObject] = []

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

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        
        var cellW = (screenRect.width - kWaterfallPadding * 3) / 2
        var cellH: CGFloat = 0
        
        if self.isMyDraft {
            let draftNote = self.draftNotes[indexPath.item]
            let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
            let imageH = imageSize.height
            let imageW = imageSize.width
            let imageRatio = imageH / imageW
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewH
        } else {
            let note = self.notes[indexPath.item]
            let coverPhotoRatio = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol))
            cellH = cellW * coverPhotoRatio + kWaterfallCellBottomViewH
        }
        
        return CGSize(width: cellW, height: cellH)
    }
    
}

// MARK: - IndicatorInfoProvider

extension WaterfallVC: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: self.channel)
    }
    
}
