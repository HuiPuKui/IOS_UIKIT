//
//  NoteDetailVC-DelReply.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/7.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func delReply(_ reply: LCObject, _ indexPath: IndexPath) {
        self.showDelAlert(for: "回复") { _ in
            // 云端数据
            reply.delete { _ in }
            self.updateCommentCount(by: -1)
            
            // 内存数据
            self.replies[indexPath.section].replies.remove(at: indexPath.row)
            
            // UI
            self.tableView.reloadData()
        }
    }
    
}
