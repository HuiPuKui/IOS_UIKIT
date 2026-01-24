//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/13.
//

import Foundation
import PopupDialog

extension NoteEditVC {
    
    func setUI() {
        addPopup()
        setDraftNoteEditUI()
        setNoteEditUI()
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
    
    private func setNoteEditUI() {
        if let note = self.note {
            self.titleTextField.text = note.getExactStringVal(kTitleCol)
            self.textView.text = note.getExactStringVal(kTextCol)
            self.channel = note.getExactStringVal(kChannelCol)
            self.subChannel = note.getExactStringVal(kSubChannelCol)
            self.poiName = note.getExactStringVal(kPOINameCol)
            
            if !self.subChannel.isEmpty {
                self.updateChannelUI()
            }
            
            if !self.poiName.isEmpty {
                self.updatePOINameUI()
            }
        }
    }
    
}

extension NoteEditVC {
    
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

extension NoteEditVC {
    
    private func addPopup() {
        let icon = largeIcon("info.circle")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: self,
            action: #selector(showPopup)
        )
        
        let pv = PopupDialogDefaultView.appearance()
        pv.titleColor = .label
        pv.messageFont = .systemFont(ofSize: 13)
        pv.messageColor = .secondaryLabel
        pv.messageTextAlignment = .natural
        
        let cb = CancelButton.appearance()
        cb.titleColor = .label
        cb.separatorColor = mainColor
        
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = .secondarySystemBackground
        pcv.cornerRadius = 10 
    }
    
}

extension NoteEditVC {
    
    @objc private func showPopup() {
        let title = "发布小贴士"
        let message =
            """
            小粉书鼓励向上、真实、原创的内容，含以下内容的笔记将不会被推荐：
            1.含有不文明语言、过度性感图片；
            2.含有网址链接、联系方式、二维码或售卖语言；
            3.冒充他人身份或搬运他人作品；
            4.通过有奖方式诱导他人点赞、评论、收藏、转发、关注；
            5.为刻意博取眼球，在标题、封面等处使用夸张表达。
            """
        
        let popup = PopupDialog(
            title: title,
            message: message,
            transitionStyle: .zoomIn
        )
        
        let btn = CancelButton(
            title: "我知道了",
            action: nil
        )
        
        popup.addButton(btn)
        
        self.present(popup, animated: true)
    }
    
}
