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
        
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(commentTapped))
        commentView.tag = section
        commentView.addGestureRecognizer(commentTap)
        
        return commentView
    }
    
}

extension NoteDetailVC {
    
    @objc private func commentTapped(_ tap: UITapGestureRecognizer) {
        if let user = LCApplication.default.currentUser {
            
            if let section = tap.view?.tag,
               let commentAuthor = self.comments[section].get(kUserCol) as? LCUser,
               commentAuthor == user {
                
                let alert = UIAlertController(title: nil, message: "你的评论: ", preferredStyle: .actionSheet)
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    // 回复
                }
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    
                }
                let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                    
                }
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alert.addAction(replyAction)
                alert.addAction(copyAction)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
                
            } else {
                // 回复
            }
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
}
