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
            
            // 依赖注入(Dependency Injection)
            let detailVC = self.storyboard!.instantiateViewController(identifier: kNoteDetailVCID) { coder in
                return NoteDetailVC(coder: coder, note: self.notes[indexPath.item])
            }
            
            if let cell = collectionView.cellForItem(at: indexPath) as? WaterfallCell {
                detailVC.isLikeFromWaterfallCell = cell.isLike
            }
            
            detailVC.delNoteFinished = {
                self.notes.remove(at: indexPath.item)
                collectionView.performBatchUpdates {
                    collectionView.deleteItems(at: [indexPath])
                }
            }
            
            detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true)
            
        }
    }
    
}
