//
//  WaterfallCell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/8.
//

import UIKit
import LeanCloud

class WaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var note: LCObject? {
        didSet {
            guard
                let note = self.note,
                let author = note.get(kAuthorCol) as? LCUser
            else { return }
            
            let coverPhotoURL = note.getImageURL(from: kCoverPhotoCol, .coverPhoto)
            
            let avatarURL = author.getImageURL(from: kAvatarCol, .avatar)
            
            self.titleLabel.text = note.getExactStringVal(kTitleCol)
            self.likeBtn.setTitle("\(note.getExactIntVal(kLikeCountCol))", for: .normal)
            
            // TODO: 点赞功能 + 判断是否已点赞
        }
    }
    
}
