//
//  WaterfallCell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/8.
//

import UIKit
import LeanCloud
import Kingfisher

class WaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var likeCount = 0 {
        didSet {
            self.likeBtn.setTitle(self.likeCount.formattedStr, for: .normal)
        }
    }
    
    var isLike: Bool {
        return self.likeBtn.isSelected
    }
    
    var note: LCObject? {
        didSet {
            guard
                let note = self.note,
                let author = note.get(kAuthorCol) as? LCUser
            else { return }
            
            let coverPhotoURL = note.getImageURL(from: kCoverPhotoCol, .coverPhoto)
            self.imageView.kf.setImage(with: coverPhotoURL, options: [.transition(.fade(0.2))])
            
            let avatarURL = author.getImageURL(from: kAvatarCol, .avatar)
            self.avatarImageView.kf.setImage(with: avatarURL)
            
            self.titleLabel.text = note.getExactStringVal(kTitleCol)
            self.likeBtn.setTitle("\(note.getExactIntVal(kLikeCountCol))", for: .normal)
            
            // TODO: 点赞功能 + 判断是否已点赞
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let icon = UIImage(systemName: "heart.fill")?.withTintColor(mainColor, renderingMode: .alwaysOriginal)
        self.likeBtn.setImage(icon, for: .selected)
    }
    
    @IBAction func like(_ sender: Any) {
        if let user = LCApplication.default.currentUser {
            self.likeBtn.isSelected.toggle()
            self.isLike ? (self.likeCount += 1) : (self.likeCount -= 1)
            
            guard let note = self.note else { return }
            if self.isLike {
                let userLike = LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: self.note)
                userLike.save { _ in }
                
                try? note.increase(kLikeCountCol)
            } else {
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst { res in
                    if case let .success(object: userLike) = res {
                        userLike.delete { _ in }
                    }
                }
                
                try? note.set(kLikeCountCol, value: self.likeCount)
                note.save { _ in }
            }
        } else {
            showGlobalTextHUD("请先登录哦")
        }
    }
    
}
