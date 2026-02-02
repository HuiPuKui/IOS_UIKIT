//
//  NoteDetailVC-TVDelegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/27.
//

import Foundation
import LeanCloud

extension NoteDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentViewID) as! CommentView
        let comment = self.comments[section]
        commentView.comment = comment
        
        if let commentAuthor = comment.get(kUserCol) as? LCUser,
           let noteAuthor = self.author,
           commentAuthor == noteAuthor {
            commentView.authorLabel.isHidden = false
        }
        
        return commentView
    }
    
}
