//
//  NoteDetailVC-PostComment.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/5.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func postComment() {
        let user = LCApplication.default.currentUser!
        
        do {
            // 云端数据
            let comment = LCObject(className: kCommentTable)
            try comment.set(kTextCol, value: self.textView.unwrappedText)
            try comment.set(kUserCol, value: user)
            try comment.set(kNoteCol, value: self.note)
            
            comment.save { _ in }
            
            try? self.note.increase(kCommentCountCol)
            
            // 内存数据
            self.comments.insert(comment, at: 0)
            
            // UI
            self.tableView.performBatchUpdates {
                self.tableView.insertSections(IndexSet(integer: 0), with: .automatic)
            }
            
            self.commentCount += 1
            
        } catch {
            print("给 Comment 表的字段赋值失败: \(error)")
        }
    }
    
}
