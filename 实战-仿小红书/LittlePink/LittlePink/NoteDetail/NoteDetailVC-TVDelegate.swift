//
//  NoteDetailVC-TVDelegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/27.
//

import Foundation

extension NoteDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentViewID) as! CommentView
        commentView.comment = self.comments[section]
        return commentView
    }
    
}
