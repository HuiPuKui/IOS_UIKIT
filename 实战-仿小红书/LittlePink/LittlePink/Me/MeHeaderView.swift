//
//  MeHeaderView.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/11.
//

import UIKit
import LeanCloud
import Kingfisher

class MeHeaderView: UIView {
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var backOrSlideBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var likedAndFavedLabel: UILabel!
    @IBOutlet weak var editOrFollowBtn: UIButton!
    @IBOutlet weak var settingOrChatBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.editOrFollowBtn.makeCapsule()
        self.settingOrChatBtn.makeCapsule()
    }
    
    var user: LCUser! {
        didSet {
            self.avatarImageView.kf.setImage(with: self.user.getImageURL(from: kAvatarCol, .avatar))
            self.nickNameLabel.text = self.user.getExactStringVal(kNickNameCol)
            
            let gender = self.user.getExactBoolValDefaultF(kGenderCol)
            self.genderLabel.text = gender ? "♂︎" : "♀︎"
            self.genderLabel.textColor = gender ? blueColor : mainColor
            
            self.idLabel.text = "\(self.user.getExactIntVal(kIDCol))"
            
            let intro = self.user.getExactStringVal(kIntroCol)
            self.introLabel.text = intro.isEmpty ? "填写个人简介更容易获得关注哦,点击此处填写" : intro
        }
    }

}
