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
        self.showDelAlert(for: "评论") { _ in
            // 远端数据
            comment.delete { _ in }
            self.updateCommentCount(by: -1)
            
            // 内存数据
            self.comments.remove(at: section)
            
            // UI
            self.tableView.reloadData()
        }
    }
    
}
