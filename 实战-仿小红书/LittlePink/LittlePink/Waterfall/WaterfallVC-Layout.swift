//
//  WaterfallVC-Layout.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/23.
//

import Foundation
import CHTCollectionViewWaterfallLayout

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        
        var cellW = (screenRect.width - kWaterfallPadding * 3) / 2
        var cellH: CGFloat = 0
        
        if self.isMyDraft, indexPath.item == 0 {
            cellH = 100
        } else if self.isDraft {
            let draftNote = self.draftNotes[indexPath.item]
            let imageSize = UIImage(draftNote.coverPhoto)?.size ?? imagePH.size
            let imageH = imageSize.height
            let imageW = imageSize.width
            let imageRatio = imageH / imageW
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellBottomViewH
        } else {
            let offset = self.isMyDraft ? 1 : 0
            let note = self.notes[indexPath.item - offset]
            let coverPhotoRatio = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol))
            cellH = cellW * coverPhotoRatio + kWaterfallCellBottomViewH
        }
        
        return CGSize(width: cellW, height: cellH)
    }
    
}
