//
//  NoteDetailVC-PostReply.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/5.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func postReply() {
        let user = LCApplication.default.currentUser
        
        do {
            // 云端数据
            let reply = LCObject(className: kReplyTable)
            
            try reply.set(kTextCol, value: self.textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: self.comments[self.commentSection])
            
            reply.save { _ in }
            
            try self.note.increase(kCommentCountCol)
            self.note.save { _ in }
            
            // 内存数据
            self.replies[self.commentSection].replies.append(reply)
            
            print(self.replies)
            
            // UI
            self.tableView.performBatchUpdates {
                self.tableView.insertRows(
                    at: [IndexPath(row: self.replies[self.commentSection].replies.count - 1,section: self.commentSection)],
                    with: .automatic
                )
            }
            self.commentCount += 1
            
        } catch {
            print("给 Reply 表的字段赋值失败: \(error)")
        }
    }
    
}
