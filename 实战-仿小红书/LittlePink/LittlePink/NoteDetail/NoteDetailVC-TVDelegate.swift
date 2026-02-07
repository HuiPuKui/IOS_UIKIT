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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separatorLine = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentSectionFooterViewID)
        return separatorLine
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = LCApplication.default.currentUser {
            let reply = self.replies[indexPath.section].replies[indexPath.row]
            guard let replyAuthor = reply.get(kUserCol) as? LCUser else { return }
            
            if user == replyAuthor {
                let replyText = reply.getExactStringVal(kTextCol)
                
                let alert = UIAlertController(
                    title: nil,
                    message: "你的回复: \(replyText)",
                    preferredStyle: .actionSheet
                )
                
                let subReplyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    
                }
                
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    UIPasteboard.general.string = replyText
                }
                
                let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                    self.delReply(reply, indexPath)
                }
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alert.addAction(subReplyAction)
                alert.addAction(copyAction)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
            } else {
                
            }
            
            
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
}

extension NoteDetailVC {
    
    @objc private func commentTapped(_ tap: UITapGestureRecognizer) {
        if let user = LCApplication.default.currentUser {
            
            guard let section = tap.view?.tag else { return }
            let comment = self.comments[section]
            guard let commentAuthor = comment.get(kUserCol) as? LCUser else { return }
            let commentAuthorNickName = commentAuthor.getExactStringVal(kNickNameCol)
            
            if user == commentAuthor {
                
                let commentText = comment.getExactStringVal(kTextCol)
                
                let alert = UIAlertController(
                    title: nil,
                    message: "你的评论: \(commentText)",
                    preferredStyle: .actionSheet
                )
                
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    self.prepareForReply(commentAuthorNickName, section)
                }
                
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    UIPasteboard.general.string = commentText
                }
                
                let deleteAction = UIAlertAction(title: "删除", style: .destructive) { _ in
                    self.delComment(comment, section)
                }
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                
                alert.addAction(replyAction)
                alert.addAction(copyAction)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
                
            } else {
                // 回复
                self.prepareForReply(commentAuthorNickName, section)
            }
            
        } else {
            self.showTextHUD("请先登录哦")
        }
    }
    
}

extension NoteDetailVC {
    
    private func prepareForReply(_ commentAuthorNickName: String, _ section: Int) {
        self.showTextView(true, "回复 \(commentAuthorNickName)")
        self.commentSection = section
    }
    
}
