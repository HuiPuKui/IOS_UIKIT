//
//  CommentView.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/27.
//

import UIKit
import LeanCloud
import Kingfisher

class CommentView: UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    var comment: LCObject? {
        didSet {
            guard let comment = self.comment else { return }
            
            if let user = comment.get(kUserCol) as? LCUser {
                self.avatarImageView.kf.setImage(with: user.getImageURL(from: kAvatarCol, .avatar))
                self.nickNameLabel.text = user.getExactStringVal(kNickNameCol)
            }
            
            let commentText = comment.getExactStringVal(kTextCol)
            let createdAt = comment.createdAt?.value
            let dateText = createdAt == nil ? "刚刚" : createdAt!.formattedDate
            
            commentTextLabel.attributedText = commentText.spliceAttrStr(dateText)
        }
    }

}
