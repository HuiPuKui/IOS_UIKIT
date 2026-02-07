//
//  WaterfallCellLike.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/13.
//

import LeanCloud

extension WaterfallCell {
    
    @objc func likeBtnTappedWhenLogin() {
        
        if self.likeCount != self.currentLikedCount {
            guard let note = self.note else { return }
            
            let user = LCApplication.default.currentUser!
            
            let offset = self.isLike ? 1 : -1
            self.currentLikedCount += offset
            
            if self.isLike {
                let userLike = LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: self.note)
                userLike.save { _ in }
                
                try? note.increase(kLikeCountCol)
                note.save { _ in }
            } else {
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst { res in
                    if case let .success(object: userLike) = res {
                        userLike.delete { _ in }
                    }
                }
                
                try? note.set(kLikeCountCol, value: self.likeCount)
                note.save { _ in }
            }
        }
    }
    
}
