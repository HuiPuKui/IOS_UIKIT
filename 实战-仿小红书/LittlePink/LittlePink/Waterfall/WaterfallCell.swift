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
    
    var isMyselfLike: Bool = false
    
    var likeCount = 0 {
        didSet {
            self.likeBtn.setTitle(self.likeCount.formattedStr, for: .normal)
        }
    }
    
    var currentLikedCount = 0
    
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
            self.nickNameLabel.text = author.getExactStringVal(kNickNameCol)
            self.likeCount = note.getExactIntVal(kLikeCountCol)
            self.currentLikedCount = self.likeCount
            self.likeBtn.setTitle("\(note.getExactIntVal(kLikeCountCol))", for: .normal)
            
            // 判断是否已点赞
            if self.isMyselfLike {
                DispatchQueue.main.async {
                    self.likeBtn.isSelected = true
                }
            } else {
                if let user = LCApplication.default.currentUser {
                    let query = LCQuery(className: kUserLikeTable)
                    query.whereKey(kUserCol, .equalTo(user))
                    query.whereKey(kNoteCol, .equalTo(note))
                    query.getFirst { res in
                        if case .success = res {
                            DispatchQueue.main.async {
                                self.likeBtn.isSelected = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let icon = UIImage(systemName: "heart.fill")?.withTintColor(mainColor, renderingMode: .alwaysOriginal)
        self.likeBtn.setImage(icon, for: .selected)
    }
    
    @IBAction func like(_ sender: Any) {
        if let _ = LCApplication.default.currentUser {
            self.likeBtn.isSelected.toggle()
            self.isLike ? (self.likeCount += 1) : (self.likeCount -= 1)
            
            NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(likeBtnTappedWhenLogin),
                object: nil
            )
            perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)
        } else {
            showGlobalTextHUD("请先登录哦")
        }
    }
    
}

