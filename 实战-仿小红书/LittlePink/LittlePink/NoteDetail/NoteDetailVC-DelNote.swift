//
//  NoteDetailVC-DelNote.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/13.
//

import Foundation
import LeanCloud

extension NoteDetailVC {
    
    func delNote() {
        let alert = UIAlertController(title: "提示", message: "确认删除此笔记", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .default) { _ in
            // 数据
            self.delLCNote()
            
            // UI
            
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true)
    }
    
    private func delLCNote() {
        self.note.delete { res in
            if case .success = res {
                self.showTextHUD("笔记已删除")
            }
        }
    }
    
}
