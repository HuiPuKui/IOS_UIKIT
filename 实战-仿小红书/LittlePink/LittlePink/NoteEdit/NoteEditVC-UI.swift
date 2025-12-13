//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import Foundation

extension NoteEditVC {
    
    func setUI() {
        setDraftNoteEditUI()
    }
    
}

// MARK: - 编辑草稿笔记时

extension NoteEditVC {

    private func setDraftNoteEditUI() {
        if let draftNote = self.draftNote {
            self.titleTextField.text = draftNote.title
            self.textView.text = draftNote.text
            self.channel = draftNote.channel!
            self.subChannel = draftNote.subChannel!
            self.poiName = draftNote.poiName!
            
            if !self.subChannel.isEmpty {
                self.updateChannelUI()
            }
            
            if !self.poiName.isEmpty {
                self.updatePOINameUI()
            }
        }
    }
    
    func updateChannelUI() {
        self.channelIcon.tintColor = blueColor
        self.channelLabel.text = self.subChannel
        self.channelLabel.textColor = blueColor
        self.channelPlaceholderLabel.isHidden = true
    }
    
    func updatePOINameUI() {
        if self.poiName == "" {
            self.poiNameIcon.tintColor = .label
            self.poiNameLabel.text = "添加地点"
            self.poiNameLabel.textColor = .label
        } else {
            self.poiNameIcon.tintColor = blueColor
            self.poiNameLabel.text = self.poiName
            self.poiNameLabel.textColor = blueColor
        }
    }
}
