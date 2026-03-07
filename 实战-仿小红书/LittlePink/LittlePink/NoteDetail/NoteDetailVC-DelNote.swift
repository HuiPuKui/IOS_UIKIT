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
        self.showDelAlert(for: "笔记") { _ in
            // 数据
            self.delLCNote()
            
            // UI
            self.dismiss(animated: true) {
                self.delNoteFinished?()
            }
        }
    }
    
    private func delLCNote() {
        self.note.delete { res in
            if case .success = res {
                // 用户表的 noteCount 减 1
                try? self.author?.set(
                    kNoteCountCol,
                    value: self.author!.getExactIntVal(kNoteCountCol) - 1
                )
                self.author?.save { _ in }
                
                DispatchQueue.main.async {
                    self.showTextHUD("笔记已删除")
                }
            }
        }
    }
    
}
