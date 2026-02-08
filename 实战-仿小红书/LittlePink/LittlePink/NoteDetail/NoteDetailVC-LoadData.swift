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
//        query.whereKey("\(kUserCol).\(kNickNameCol)", .selected)
        query.whereKey(kUserCol, .included)
        query.whereKey(kCreatedAtCol, .descending)
        query.limit = kCommentsOffset
        
        query.find { res in
            self.hideLoadHUD()
            if case let .success(objects: comments) = res {
                self.comments = comments
                self.getReplies()
            }
        }
    }
    
    func getReplies() {
        var repliesDic: [Int: [LCObject]] = [:]
        let group = DispatchGroup()
        
        for (index, comment) in self.comments.enumerated() {
            group.enter()
            let query = LCQuery(className: kReplyTable)
            query.whereKey(kCommentCol, .equalTo(comment))
            query.whereKey(kUserCol, .included)
            query.whereKey(kReplyToUserCol, .included)
            query.whereKey(kCreatedAtCol, .ascending)
            
            query.find { res in
                if case let .success(objects: replies) = res {
                    repliesDic[index] = replies
                } else {
                    repliesDic[index] = []
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.replies = repliesDic.sorted { $0.key < $1.key }.map { ExpandableReplies(replies: $0.value) }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
