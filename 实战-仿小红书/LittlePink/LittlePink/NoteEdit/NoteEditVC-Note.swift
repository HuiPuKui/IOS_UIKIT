//
//  NoteEditVC-Note.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import Foundation
import LeanCloud

extension NoteEditVC {
    
    func createNote() {
        do {
            let noteGroup = DispatchGroup()
            
            let note = LCObject(className: kNoteTable)
            
            if let videoURL = self.videoURL {
                let video = LCFile(payload: .fileURL(fileURL: videoURL))
                video.save(to: note, as: kVideoCol, group: noteGroup)
            }
            
            if let coverPhotoData = photos[0].jpeg(.high) {
                let coverPhoto = LCFile(payload: .data(data: coverPhotoData))
//                coverPhoto.mimeType = "image/jpeg"
                coverPhoto.save(to: note, as: kCoverPhotoCol, group: noteGroup)
            }
            
            // 多个文件的存储
            // 存为 [LCFile] 类型最后会变成 [Pointer]类型（里面无 path，不方便之后的取操作），需存为以下类型:
            // ["https://1.jpg", "https://2.jpg", "https://3.jpg"]
            // 1. 把所有文件存进云端
            let photoGroup = DispatchGroup()
            var photoPaths: [Int: String] = [:]
            for (index, eachPhoto) in self.photos.enumerated() {
                if let eachPhotoData = eachPhoto.jpeg(.high) {
                    let photo = LCFile(payload: .data(data: eachPhotoData))
                    photoGroup.enter()
                    photo.save { res in
//                        print("存储photo文件保存成功/失败")
                        if case .success = res, let path = photo.url?.stringValue {
                            photoPaths[index] = path
                        }
                        photoGroup.leave()
                    }
                }
            }
            
            // 2. 得到所有 url 后进行排序
            noteGroup.enter()
            photoGroup.notify(queue: .main) {
                let photoPathsArr = photoPaths.sorted(by: <).map { $0.value }
                
                do {
                    try note.set(kPhotosCol, value: photoPathsArr)
                    note.save { _ in
//                        print("存储 photos 成功/失败")
                        noteGroup.leave()
                    }
                } catch {
                    print("字段赋值失败: \(error)")
                }
            }
            
            let coverPhotoSize = self.photos[0].size
            let coverPhotoRatio = Double(coverPhotoSize.height / coverPhotoSize.width)
            try note.set(kCoverPhotoRatioCol, value: coverPhotoRatio)
            try note.set(kTitleCol, value: self.titleTextField.exactText)
            try note.set(kTextCol, value: self.textView.exactText)
            try note.set(kChannelCol, value: self.channel.isEmpty ? "推荐" : self.channel)
            try note.set(kSubChannelCol, value: self.subChannel)
            try note.set(kPOINameCol, value: self.poiName)
            try note.set(kLikeCountCol, value: 0)
            try note.set(kFavCountCol, value: 0)
            try note.set(kCommentCountCol, value: 0)
            
            // 笔记的作者
            try note.set(kAuthorCol, value: LCApplication.default.currentUser)
            
            noteGroup.enter()
            note.save { res in
//                print("存储一般数据成功/失败")
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
//                print("笔记内容全部存储结束")
                self.showTextHUD("发布笔记成功", false)
            }
            
            if draftNote != nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
            
        } catch {
            print("字段赋值失败: \(error)")
        }
    }
    
    func postDraftNote(_ draftNote: DraftNote) {
        self.createNote()
        
        backgroundContext.perform {
            // 数据
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()

            // UI
            DispatchQueue.main.async {
                self.postDraftNoteFinished?()
            }
        }
    }
    
    func updateNote(_ note: LCObject) {
        do {
            let noteGroup = DispatchGroup()

            if !self.isVideo {
                if let coverPhotoData = photos[0].jpeg(.high) {
                    let coverPhoto = LCFile(payload: .data(data: coverPhotoData))
    //                coverPhoto.mimeType = "image/jpeg"
                    coverPhoto.save(to: note, as: kCoverPhotoCol, group: noteGroup)
                }
                
                // 多个文件的存储
                // 存为 [LCFile] 类型最后会变成 [Pointer]类型（里面无 path，不方便之后的取操作），需存为以下类型:
                // ["https://1.jpg", "https://2.jpg", "https://3.jpg"]
                // 1. 把所有文件存进云端
                let photoGroup = DispatchGroup()
                var photoPaths: [Int: String] = [:]
                for (index, eachPhoto) in self.photos.enumerated() {
                    if let eachPhotoData = eachPhoto.jpeg(.high) {
                        let photo = LCFile(payload: .data(data: eachPhotoData))
                        photoGroup.enter()
                        photo.save { res in
    //                        print("存储photo文件保存成功/失败")
                            if case .success = res, let path = photo.url?.stringValue {
                                photoPaths[index] = path
                            }
                            photoGroup.leave()
                        }
                    }
                }
                
                // 2. 得到所有 url 后进行排序
                noteGroup.enter()
                photoGroup.notify(queue: .main) {
                    let photoPathsArr = photoPaths.sorted(by: <).map { $0.value }
                    
                    do {
                        try note.set(kPhotosCol, value: photoPathsArr)
                        note.save { _ in
    //                        print("存储 photos 成功/失败")
                            noteGroup.leave()
                        }
                    } catch {
                        print("字段赋值失败: \(error)")
                    }
                }
            }
            
            let coverPhotoSize = self.photos[0].size
            let coverPhotoRatio = Double(coverPhotoSize.height / coverPhotoSize.width)
            
            try note.set(kCoverPhotoRatioCol, value: coverPhotoRatio)
            try note.set(kTitleCol, value: self.titleTextField.exactText)
            try note.set(kTextCol, value: self.textView.exactText)
            try note.set(kChannelCol, value: self.channel.isEmpty ? "推荐" : self.channel)
            try note.set(kSubChannelCol, value: self.subChannel)
            try note.set(kPOINameCol, value: self.poiName)
            
            try note.set(kHasEditCol, value: true)
            
            noteGroup.enter()
            note.save { res in
//                print("存储一般数据成功/失败")
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
//                print("笔记内容全部存储结束")
                self.showTextHUD("更新笔记成功", false)
            }
            
            self.dismiss(animated: true)
            
        } catch {
            print("字段赋值失败: \(error)")
        }
    }
    
}
