//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/24.
//

import Foundation

extension NoteEditVC {
    
    func config() {
        // 开启拖放交互
        self.photoCollectionView.dragInteractionEnabled = true
        
        self.hideKeyboardWithTappedAround()
        self.titleCountLabel.text = "\(kMaxNoteTitleCount)"
        
        // 去除 textView 文本边距(上下边距)
        let lineFragmentPadding = self.textView.textContainer.lineFragmentPadding
        self.textView.textContainerInset = UIEdgeInsets(
            top: 0,
            left: -lineFragmentPadding,
            bottom: 0,
            right: -lineFragmentPadding
        )
        self.textView.textContainer.lineFragmentPadding = 0
        
        // 设置 textView 行间距、字体、颜色
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.secondaryLabel
        ]
        self.textView.typingAttributes = typingAttributes
        
        // 修改光标颜色
        self.textView.tintColorDidChange()
        
        if let textViewIAView = Bundle.main.loadNibNamed("TextViewIAView", owner: nil, options: nil)?.first as? TextViewIAView {
            self.textView.inputAccessoryView = textViewIAView
            
            (self.textView.inputAccessoryView as! TextViewIAView).doneBtn.addTarget(
                self,
                action: #selector(resignTextView),
                for: .touchUpInside
            )
        }
    }
    
}

// MARK: - 监听

extension NoteEditVC {
        
    @objc private func resignTextView() {
        self.textView.resignFirstResponder()
    }
    
}
