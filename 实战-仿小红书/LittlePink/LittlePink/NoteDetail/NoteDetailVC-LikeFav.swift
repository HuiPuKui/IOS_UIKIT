//
//  NoteDetailVC-LikeFav.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/11.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func like() {
        if let user = LCApplication.default.currentUser {
            // UI
            self.isLike ? (self.likeCount += 1) : (self.likeCount -= 1)
            // 数据
            if self.isLike {
                let userLike = LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: self.note)
                userLike.save { _ in }
                
                try? self.note.increase(kLikeCountCol)
            } else {
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(self.note))
                query.getFirst { res in
                    if case let .success(object: userLike) = res {
                        userLike.delete { _ in }
                    }
                }
                
                try? self.note.set(kLikeCountCol, value: self.likeCount)
                self.note.save { _ in }
            }
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
    func fav() {
        if let user = LCApplication.default.currentUser {
            
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
}
