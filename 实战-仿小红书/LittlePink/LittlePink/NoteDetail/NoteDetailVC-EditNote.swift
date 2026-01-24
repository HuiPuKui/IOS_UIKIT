//
//  NoteDetailVC-EditNote.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/24.
//

import Foundation
import LeanCloud
import Kingfisher

extension NoteDetailVC {
    
    func editNote() {
        var photos: [UIImage] = []
        
        if let coverPhotoPath = (self.note.get(kCoverPhotoCol) as? LCFile)?.url?.stringValue,
           let coverPhoto = ImageCache.default.retrieveImageInMemoryCache(forKey: coverPhotoPath) {
            photos.append(coverPhoto)
        }
        
        if let photoPaths = self.note.get(kPhotosCol)?.arrayValue as? [String] {
            let otherPhotos = photoPaths.compactMap {
                ImageCache.default.retrieveImageInMemoryCache(forKey: $0)
            }
            photos.append(contentsOf: otherPhotos)
        }
        
        let vc = self.storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
        vc.note = self.note
        vc.photos = photos
        vc.videoURL = nil // 此处省略视频
        
        vc.updateNoteFinished = { noteID in 
            let query = LCQuery(className: kNoteTable)
            query.get(noteID) { res in
                if case let .success(object: note) = res {
                    self.note = note
                    self.showNote(true)
                }
            }
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
