//
//  ReplyCell.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/6.
//

import UIKit
import LeanCloud
import Kingfisher

class ReplyCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var replyTextLabel: UILabel!
    @IBOutlet weak var showAllReplyBtn: UIButton!
    
    var reply: LCObject? {
        didSet {
            guard let reply = self.reply else { return }
            
            if let user = reply.get(kUserCol) as? LCUser {
                self.avatarImageView.kf.setImage(with: user.getImageURL(from: kAvatarCol, .avatar))
                self.nickNameLabel.text = user.getExactStringVal(kNickNameCol)
            }
            
            let replyText = reply.getExactStringVal(kTextCol)
            let createdAt = reply.createdAt?.value
            let dateText = createdAt == nil ? "刚刚" : createdAt!.formattedDate
            
            self.replyTextLabel.attributedText = replyText.spliceAttrStr(dateText)
        }
    }

}
