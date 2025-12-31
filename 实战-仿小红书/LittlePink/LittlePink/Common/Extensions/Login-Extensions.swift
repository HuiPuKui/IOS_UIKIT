//
//  Login-Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/1/1.
//

import Foundation
import LeanCloud

extension UIViewController {
    
    func configAfterLogin(_ user: LCUser, _ nickName: String, _ email: String = "") {
        if let _ = user.get(kNickNameCol) {
            
        } else {
            // 首次登录（即注册）
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")!
            
            if let avatarData = randomAvatar.pngData() {
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                
                avatarFile.save(to: user, as: kAvatarCol)
            }
            
            do {
                if email != "" {
                    user.email = LCString(email)
                }
                
                try user.set(kNickNameCol, value: nickName)
            } catch {
                print("给 User 表的字段赋值失效: \(error)")
                return
            }
            
            user.save { result in
                if case .success = result {
                    
                }
            }
        }
    }
    
}
