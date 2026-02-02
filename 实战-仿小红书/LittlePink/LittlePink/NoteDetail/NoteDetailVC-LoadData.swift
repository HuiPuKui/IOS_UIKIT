//
//  NoteDetailVC-LoadData.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/2.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func getComments() {
        self.showLoadHUD()
        
        let query = LCQuery(className: kCommentTable)
        query.whereKey(kNoteCol, .equalTo(self.note))
        query.whereKey("\(kUserCol).\(kNickNameCol)", .selected)
        query.whereKey(kUserCol, .included)
        
        query.find { res in
            self.hideLoadHUD()
            if case let .success(objects: comments) = res {

            }
        }
    }
    
}
