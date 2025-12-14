//
//  NoteEditVC-DraftNote.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import Foundation

extension NoteEditVC {
    
    func createDraftNote() {
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            if self.isVideo {
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            
            self.handlePhotos(draftNote)
            
            draftNote.isVideo = self.isVideo
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUD("保存草稿成功")
            }
        }
        
        dismiss(animated: true)
    }
    
    func updateDraftNote(_ draftNote: DraftNote) {
        backgroundContext.perform {
            if !self.isVideo {
                self.handlePhotos(draftNote)
            }
                
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NoteEditVC {
    
    private func handlePhotos(_ draftNote: DraftNote) {
        // 封面图片
        draftNote.coverPhoto = self.photos[0].jpeg(.high)
        
        // 所有图片
        var photos: [Data] = []
        for photo in self.photos {
            if let pngData = photo.pngData() {
                photos.append(pngData)
            }
        }
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote) {
        
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        
        draftNote.channel = self.channel
        draftNote.subChannel = self.subChannel
        draftNote.poiName = self.poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
    }
    
}
