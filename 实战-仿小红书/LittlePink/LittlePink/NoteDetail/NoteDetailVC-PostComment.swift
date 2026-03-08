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
            let commentText = self.textView.unwrappedText
            // 云端数据
            let comment = LCObject(className: kCommentTable)
            try comment.set(kTextCol, value: commentText)
            try comment.set(kUserCol, value: user)
            try comment.set(kNoteCol, value: self.note)
            
            comment.save { res in
                if case .success = res {
                    self.sendPush(commentText)
                }
            }
            
            self.updateCommentCount(by: 1)
            
            // 内存数据
            self.comments.insert(comment, at: 0)
            self.replies.insert(ExpandableReplies(replies: []), at: 0)
            
            // UI
            self.tableView.performBatchUpdates {
                self.tableView.insertSections(IndexSet(integer: 0), with: .automatic)
            }
        } catch {
            print("给 Comment 表的字段赋值失败: \(error)")
        }
    }
    
    private func sendPush(_ commentText: String) {
        guard let author = self.author, let noteID = self.note.objectId?.stringValue else { return }
        
        let query = LCQuery(className: "_Installation")
        query.whereKey(kUserCol, .equalTo(author))
        
        let alertDic: [String: Any] = [
            "title": "\(author.getExactStringVal(kNickNameCol))对您的笔记发表了评论:",
            "body": commentText
        ]
        
        let payload: [String: Any] = [
            "alert": alertDic,
            "badge": "Increment",
            "noteID":noteID
        ]
        
        LCPush.send(data: payload, query: query) { _ in }
    }
    
}
