//
//  NoteDetailVC-TVDataSource.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/27.
//

import Foundation
import LeanCloud

extension NoteDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let replyCount = self.replies[section].replies.count
        
        if replyCount > 1 && !self.replies[section].isExpanded {
            return 1
        }
        
        return replyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReplyCellID, for: indexPath) as! ReplyCell
        let reply = self.replies[indexPath.section].replies[indexPath.row]
        
        cell.reply = reply
        
        if let replyAuthor = reply.get(kUserCol) as? LCUser,
           let noteAuthor = self.author,
           replyAuthor == noteAuthor {
            cell.authorLabel.isHidden = false
        }
        
        let replyCount = self.replies[indexPath.section].replies.count
        
        if replyCount > 1, !self.replies[indexPath.section].isExpanded {
            cell.showAllReplyBtn.isHidden = false
            cell.showAllReplyBtn.setTitle("展开 \(replyCount - 1) 条回复", for: .normal)
            cell.showAllReplyBtn.tag = indexPath.section
            cell.showAllReplyBtn.addTarget(self, action: #selector(showAllReply), for: .touchUpInside)
        } else {
            cell.showAllReplyBtn.isHidden = true
        }
        
        return cell
    }

}

extension NoteDetailVC {
    
    @objc private func showAllReply(sender: UIButton) {
        let section = sender.tag
        
        self.replies[section].isExpanded = true
        
        self.tableView.performBatchUpdates {
            self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
}
