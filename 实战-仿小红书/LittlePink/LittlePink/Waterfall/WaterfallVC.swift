//
//  WaterfallVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/8.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

class WaterfallVC: UICollectionViewController {
    
    var channel = ""
    var draftNotes: [DraftNote] = []
    
    var isMyDraft = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        
        self.getDraftNotes()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        
        let cellW = (screenRect.width - kWaterfallPadding * 3) / 2
        var cellH: CGFloat = 0
        
        if self.isMyDraft {
            let draftNote = self.draftNotes[indexPath.item]
            let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
            let imageH = imageSize.height
            let imageW = imageSize.width
            let imageRatio = imageH / imageW
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewH
        } else {
            cellH = UIImage(named: "\(indexPath.item + 1)")!.size.height
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
