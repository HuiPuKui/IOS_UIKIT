//
//  NoteDetailVC-Helper.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/24.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func showDelAction(from name: String, confirmHandler: ((UIAlertAction) -> ())?) {
        let alert = UIAlertController(title: "提示", message: "确认删除此\(name)", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .default, handler: confirmHandler) 
        
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
    
    func comment() {
        if let _ = LCApplication.default.currentUser {
            self.showTextView()
        } else {
            showTextHUD("请先登录哦")
        }
    }
    
    func showTextView(_ isReply: Bool = false, _ textViewPH: String = kNoteCommentPH) {
        // reset
        self.isReply = isReply
        self.textView.placeholder = textViewPH
        
        // UI
        self.textView.becomeFirstResponder()
        self.textViewBarView.isHidden = false
    }
    
    func hideAndResetTextView() {
        self.textView.resignFirstResponder()
        self.textView.text = ""
    }
    
}
