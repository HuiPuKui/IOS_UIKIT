//
//  NoteDetailVC-Fav.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/13.
//

import LeanCloud

extension NoteDetailVC {
    
    func fav() {
        if let _ = LCApplication.default.currentUser {
            // UI
            self.isFav ? (self.favCount += 1) : (self.favCount -= 1)
            
            NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(favBtnTappedWhenLogin),
                object: nil
            )
            perform(#selector(favBtnTappedWhenLogin), with: nil, afterDelay: 1)
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
    @objc private func favBtnTappedWhenLogin() {
        if self.favCount != self.currentFavCount {
            let user = LCApplication.default.currentUser!
            let authorObjectId = self.author?.objectId?.stringValue ?? ""
            
            let offset = self.isFav ? 1 : -1
            self.currentFavCount += offset
            
            // 数据
            if self.isFav {
                let userFav = LCObject(className: kUserFavTable)
                try? userFav.set(kUserCol, value: user)
                try? userFav.set(kNoteCol, value: self.note)
                userFav.save { _ in }
                
                try? self.note.increase(kFavCountCol)
                
                LCObject.userInfo(where: authorObjectId, increase: kFavCountCol)
            } else {
                let query = LCQuery(className: kUserFavTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(self.note))
                query.getFirst { res in
                    if case let .success(object: userFav) = res {
                        userFav.delete { _ in }
                    }
                }
                
                try? self.note.set(kFavCountCol, value: self.favCount)
                self.note.save { _ in }
                
                LCObject.userInfo(where: authorObjectId, decrease: kFavCountCol, to: self.favCount)
            }
        }
    }
    
}
