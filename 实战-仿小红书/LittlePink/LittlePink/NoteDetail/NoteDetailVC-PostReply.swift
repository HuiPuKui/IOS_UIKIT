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
            let comment = self.comments[self.commentSection]
            
            // 云端数据
            let reply = LCObject(className: kReplyTable)
            
            try reply.set(kTextCol, value: self.textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: comment)
            
            if let replyToUser = self.replyToUser {
                try reply.set(kReplyToUserCol, value: replyToUser)
            }
            
            reply.save { res in
                if case .success = res {
                    if let hasReply = comment.get(kHasReplyCol)?.boolValue, hasReply != true {
                        try? comment.set(kHasReplyCol, value: true)
                        comment.save { _ in }
                    }
                }
            }
            
            self.updateCommentCount(by: 1)
            
            // 内存数据
            self.replies[self.commentSection].replies.append(reply)
            
            // UI
            if self.replies[self.commentSection].isExpanded {
                self.tableView.performBatchUpdates {
                    self.tableView.insertRows(
                        at: [
                            IndexPath(
                                row: self.replies[self.commentSection].replies.count - 1,
                                section: self.commentSection
                            )
                        ],
                        with: .automatic
                    )
                }
            } else {
                let cell = self.tableView.cellForRow(
                    at: IndexPath(row: 0, section: self.commentSection)
                ) as! ReplyCell
                
                cell.showAllReplyBtn.setTitle(
                    "展示 \(self.replies[self.commentSection].replies.count - 1) 条回复",
                    for: .normal
                )
            }
        } catch {
            print("给 Reply 表的字段赋值失败: \(error)")
        }
    }
    
}
