//
//  NoteEditVC-Helper.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import Foundation

extension NoteEditVC {
    
    func isValidateNote() -> Bool {
        guard !self.photos.isEmpty else {
            showTextHUD("至少需要传一张图片哦")
            return false
        }
        
        guard self.textViewIAView.currentTextCount <= kMaxNoteTextCount else {
            showTextHUD("正文最多输入\(kMaxNoteTextCount)字哦")
            return false
        }
        
        return true
    }
    
    func handleTFEditChanged() {
        // 优化系统输入法拼音输入未完成时候计数问题
        guard self.titleTextField.markedTextRange == nil else { return }
        
        if self.titleTextField.unwrappedText.count > kMaxNoteTitleCount {
            self.titleTextField.text = String(self.titleTextField.unwrappedText.prefix(kMaxNoteTitleCount))
            
            self.showTextHUD("标题最多输入\(kMaxNoteTitleCount)字哦")
            
            DispatchQueue.main.async {
                let end = self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(
                    from: end,
                    to: end
                )
            }
        }
        
        self.titleCountLabel.text = "\(kMaxNoteTitleCount - self.titleTextField.unwrappedText.count)"
    }
    
}
