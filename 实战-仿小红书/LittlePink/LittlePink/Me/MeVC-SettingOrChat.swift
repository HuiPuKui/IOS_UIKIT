//
//  MeVC-SettingOrChat.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/15.
//

import Foundation
import LeanCloud

extension MeVC {
    
    @objc func settingOrChat() {
        if self.isMySelf {
            
        } else {
            if let _ = LCApplication.default.currentUser {
                self.showTextHUD("私信功能")
            } else {
                self.showLoginHUD()
            }
        }
    }
    
}
