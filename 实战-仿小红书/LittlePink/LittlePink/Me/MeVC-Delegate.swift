//
//  MeVC-Delegate.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/1.
//

import Foundation
import LeanCloud

extension MeVC: EditProfileTableVCDelegate {
    
    func updateUser(_ avatar: UIImage?, _ nickName: String, _ gender: Bool, _ birth: Date?, _ intro: String) {
        if let avatar = avatar, let data = avatar.jpeg(.mudium) {
            let avatarFile = LCFile(payload: .data(data: data))
            avatarFile.save(to: self.user, as: kAvatarCol)
            
            self.meHeaderView.avatarImageView.image = avatar
        }
        
        try? self.user.set(kNickNameCol, value: nickName)
        self.meHeaderView.nickNameLabel.text = nickName
        
        try? self.user.set(kGenderCol, value: gender)
        self.meHeaderView.genderLabel.text = gender ? "♂︎" : "♀︎"
        self.meHeaderView.genderLabel.textColor = gender ? blueColor : mainColor
        
        try? self.user.set(kBirthCol, value: birth)
        
        try? self.user.set(kIntroCol, value: intro)
        self.meHeaderView.introLabel.text = intro.isEmpty ? kIntroPH : intro
        
        self.user.save { _ in }
    }
    
}
