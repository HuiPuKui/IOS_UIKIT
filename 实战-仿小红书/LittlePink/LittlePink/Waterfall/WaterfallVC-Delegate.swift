//
//  WaterfallVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/11.
//

import Foundation

extension WaterfallVC {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isMyDraft, indexPath.item == 0 {
            let navi = self.storyboard!.instantiateViewController(identifier: kDraftNotesNaviID) as! UINavigationController
            navi.modalPresentationStyle = .fullScreen
            ((navi.topViewController) as! WaterfallVC).isDraft = true
            self.present(navi, animated: true)
        } else if self.isDraft {
            let drateNote = self.draftNotes[indexPath.item]
            
            if
                let photosData = drateNote.photos,
                let photosDataArr = try? JSONDecoder().decode([Data].self, from: photosData)
            {
                let photos = photosDataArr.map {
                    return UIImage($0) ?? imagePH
                }
                
                let videoURL = FileManager.default.save(drateNote.video, to: "video", as: "\(UUID().uuidString).mp4")

                let vc = self.storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                vc.draftNote = drateNote
                vc.photos = photos
                vc.videoURL = videoURL
                vc.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                vc.postDraftNoteFinished = {
                    self.getDraftNotes()
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                self.showTextHUD("加载草稿失败")
            }
               
        } else {
            
            let offset = self.isMyDraft ? 1 : 0
            let item = indexPath.item - offset
            
            // 依赖注入(Dependency Injection)
            let detailVC = self.storyboard!.instantiateViewController(identifier: kNoteDetailVCID) { coder in
                return NoteDetailVC(coder: coder, note: self.notes[item])
            }
            
            if let cell = collectionView.cellForItem(at: indexPath) as? WaterfallCell {
                detailVC.isLikeFromWaterfallCell = cell.isLike
            }
            
            detailVC.delNoteFinished = {
                self.notes.remove(at: item)
                collectionView.performBatchUpdates {
                    collectionView.deleteItems(at: [indexPath])
                }
            }
            detailVC.isFromMeVC = self.isFromMeVC
            detailVC.fromMeVCUser = self.user
            
            detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true)
            
        }
    }
    
}
