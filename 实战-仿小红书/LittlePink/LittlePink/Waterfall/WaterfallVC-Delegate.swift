//
//  WaterfallVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/11.
//

import Foundation

extension WaterfallVC {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isMyDraft {
            let drateNote = self.draftNotes[indexPath.item]
            
            if
                let photosData = drateNote.photos,
                let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData)
            {
                let photos = photosDataArr.map {
                    return UIImage($0) ?? imagePH
                }
                
                drateNote.video
            } else {
                self.showTextHUD("加载草稿失败")
            }
               
        } else {
            
        }
    }
    
}
