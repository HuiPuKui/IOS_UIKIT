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
    }
    
}
