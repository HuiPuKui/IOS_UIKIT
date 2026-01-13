//
//  NoteDetailVC-UI.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/3.
//

import Kingfisher
import LeanCloud
import ImageSlideshow

extension NoteDetailVC {
    
    func setUI() {
        self.followBtn.layer.borderWidth = 1
        self.followBtn.layer.borderColor = mainColor.cgColor
        
        self.showNote()
        self.showLike()
    }
    
    private func showNote() {
        let authorAvatarURL = self.author?.getImageURL(from: kAvatarCol, .avatar)
        self.authorAvatarBtn.kf.setImage(with: authorAvatarURL, for: .normal)
        self.authorNickNameBtn.setTitle(self.author?.getExactStringVal(kNickNameCol), for: .normal)
        
        let coverPhotoHeight = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol)) * screenRect.width
        self.imageSlideShowHeight.constant = coverPhotoHeight
        
        let coverPhoto = KingfisherSource(url: note.getImageURL(from: kCoverPhotoCol, .coverPhoto))
        if let photoPaths = note.get(kPhotosCol)?.arrayValue as? [String] {
            var photoArr = photoPaths.compactMap { KingfisherSource(urlString: $0) }
            photoArr[0] = coverPhoto
            self.imageSlideshow.setImageInputs(photoArr)
        } else {
            self.imageSlideshow.setImageInputs([coverPhoto])
        }

        let noteTitle = self.note.getExactStringVal(kTitleCol)
        if noteTitle.isEmpty {
            self.titleLabel.isHidden = true
        } else {
            self.titleLabel.text = noteTitle
        }
        
        let noteText = self.note.getExactStringVal(kTextCol)
        if noteText.isEmpty {
            self.textLabel.isHidden = true
        } else {
            self.textLabel.text = noteText
        }
        
        let noteChannel = self.note.getExactStringVal(kChannelCol)
        let noteSubChannel = self.note.getExactStringVal(kSubChannelCol)
        self.channelBtn.setTitle(noteSubChannel.isEmpty ? noteChannel : noteSubChannel, for: .normal)
        
        if let updatedAt = self.note.updatedAt?.value {
            let hasEdit = note.getExactBoolVal(kHasEditCol)
            self.dateLabel.text = "\(hasEdit ? "编辑于 " : "")\(updatedAt.formattedDate)"
        }
        
        if let user = LCApplication.default.currentUser {
            let avatarURL = user.getImageURL(from: kAvatarCol, .avatar)
            self.avatarImageView.kf.setImage(with: avatarURL)
        }
        
        self.likeCount = note.getExactIntVal(kLikeCountCol)
        self.currentLikeCount = self.likeCount
        self.favCount = note.getExactIntVal(kFavCountCol)
        self.currentFavCount = self.favCount
        self.commentCount = note.getExactIntVal(kCommentCountCol)
    }
    
    private func showLike() {
        self.likeBtn.setSelected(selected: self.isLikeFromWaterfallCell, animated: false)
    }
    
}
