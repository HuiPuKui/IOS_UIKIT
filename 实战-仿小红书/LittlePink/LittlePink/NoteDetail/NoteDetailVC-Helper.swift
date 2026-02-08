//
//  NoteDetailVC-Helper.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/24.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func comment() {
        if let _ = LCApplication.default.currentUser {
            self.showTextView()
        } else {
            showTextHUD("请先登录哦")
        }
    }
    
    func prepareForReply(_ nickName: String, _ section: Int, _ replyToUser: LCUser? = nil) {
        self.showTextView(true, "回复 \(nickName)", replyToUser)
        self.commentSection = section
    }
    
    func showTextView(_ isReply: Bool = false, _ textViewPH: String = kNoteCommentPH, _ replyToUser: LCUser? = nil) {
        // reset
        self.isReply = isReply
        self.textView.placeholder = textViewPH
        self.replyToUser = replyToUser
        
        // UI
        self.textView.becomeFirstResponder()
        self.textViewBarView.isHidden = false
    }
    
    func hideAndResetTextView() {
        self.textView.resignFirstResponder()
        self.textView.text = ""
    }
    
}

extension NoteDetailVC {
    
    func showDelAlert(for name: String, confirmHandler: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: "提示", message: "确认删除此\(name)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .default, handler: confirmHandler) 
        
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }

    func updateCommentCount(by offset: Int) {
        // 云端数据
        try? self.note.increase(kCommentCountCol, by: offset)
        self.note.save { _ in }
        
        // UI
        self.commentCount += offset
    }
    
}
