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
            self.dismissAndShowMeVC()
        } else {
            let group = DispatchGroup()
            
            // 首次登录（即注册）
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")!
            
            if let avatarData = randomAvatar.pngData() {
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                
                avatarFile.save(to: user, as: kAvatarCol, group: group)
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
            
            group.enter()
            user.save { _ in
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.dismissAndShowMeVC()
            }
        }
    }
    
    func dismissAndShowMeVC() {
        self.hideLoadHUD()
        DispatchQueue.main.async {
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let meVC = mainSB.instantiateViewController(identifier: kMeVCID)
            
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child: meVC)
            
            self.dismiss(animated: true)
        }
    }
    
}
