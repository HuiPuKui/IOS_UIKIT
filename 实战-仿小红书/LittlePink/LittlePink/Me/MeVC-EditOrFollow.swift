//
//  MeVC-EditOrFollow.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/15.
//

import Foundation
import LeanCloud

extension MeVC {
    
    @objc func editOrFollow() {
        if self.isMySelf {
            
        } else {
            if let _ = LCApplication.default.currentUser {
                print("关注和取消关注功能")
            } else {
                self.showLoginHUD()
            }
        }
    }
    
}
