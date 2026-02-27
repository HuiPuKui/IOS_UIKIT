//
//  EditProfileTableVC-UI.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/28.
//

import Foundation
import Kingfisher

extension EditProfileTableVC {
    
    func setUI() {
        self.avatarImageView.kf.setImage(with: self.user.getImageURL(from: kAvatarCol, .avatar))
        self.nickNameLabel.text = self.user.getExactStringVal(kNickNameCol)
        self.gender = self.user.getExactBoolValDefaultF(kGenderCol)
    }
    
}
