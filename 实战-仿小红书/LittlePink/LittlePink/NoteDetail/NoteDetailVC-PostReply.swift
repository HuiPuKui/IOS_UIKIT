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
            let reply = LCObject(className: kReplyTable)
            
            try reply.set(kTextCol, value: self.textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: self.comments[self.commentSection])
            
            reply.save { _ in }
        } catch {
            print("给 Reply 表的字段赋值失败: \(error)")
        }
    }
    
}
