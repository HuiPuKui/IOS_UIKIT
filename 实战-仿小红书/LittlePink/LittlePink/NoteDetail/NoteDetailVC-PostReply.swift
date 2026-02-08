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
            
            if let replyToUser = self.replyToUser {
                try reply.set(kReplyToUserCol, value: replyToUser)
            }
            
            reply.save { _ in }
            
            self.updateCommentCount(by: 1)
            
            // 内存数据
            self.replies[self.commentSection].replies.append(reply)
            
            // UI
            self.tableView.performBatchUpdates {
                self.tableView.insertRows(
                    at: [IndexPath(row: self.replies[self.commentSection].replies.count - 1,section: self.commentSection)],
                    with: .automatic
                )
            }
        } catch {
            print("给 Reply 表的字段赋值失败: \(error)")
        }
    }
    
}
