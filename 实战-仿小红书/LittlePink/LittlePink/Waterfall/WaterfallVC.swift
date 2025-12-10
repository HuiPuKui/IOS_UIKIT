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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if self.isMyDraft {
            return self.draftNotes.count
        } else {
            return 13
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if self.isMyDraft {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: kDraftNoteWaterfallCellID,
                for: indexPath
            ) as! DraftNoteWaterfallCell
            cell.draftNote = self.draftNotes[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: kWaterfallCellID,
                for: indexPath
            ) as! WaterfallCell
            
            cell.imageView.image = UIImage(named: "\(indexPath.item + 1)")
            return cell
        }
        
    }

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
