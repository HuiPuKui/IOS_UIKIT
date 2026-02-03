//
//  NoteDetailVC-DelComment.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/4.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func delComment(_ comment: LCObject, _ section: Int) {
        self.showDelAction(from: "评论") { _ in
            // 远端数据
            comment.delete { _ in }
            try? self.note.increase(kCommentCountCol, by: -1)
            self.note.save { _ in }
            
            // 内存数据
            self.comments.remove(at: section)
            
            // UI
            self.tableView.reloadData()
            self.commentCount -= 1
        }
    }
    
}
