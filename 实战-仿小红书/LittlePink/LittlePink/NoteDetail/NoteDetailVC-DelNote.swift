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
        self.showDelAction(from: "笔记") { _ in
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
                self.showTextHUD("笔记已删除")
            }
        }
    }
    
}
