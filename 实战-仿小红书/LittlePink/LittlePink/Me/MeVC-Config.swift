//
//  MeVC-Config.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/15.
//

import Foundation
import LeanCloud

extension MeVC {
    
    func config() {
        // 去掉返回按钮文字
        self.navigationItem.backButtonDisplayMode = .minimal
        
        if let user = LCApplication.default.currentUser,
           user == self.user {
            self.isMySelf = true
        }
    }
    
}
