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
        self.nickName = self.user.getExactStringVal(kNickNameCol)
        self.gender = self.user.getExactBoolValDefaultF(kGenderCol)
        self.birth = self.user.get(kBirthCol)?.dateValue
        self.intro = self.user.getExactStringVal(kIntroCol)
    }
    
}
