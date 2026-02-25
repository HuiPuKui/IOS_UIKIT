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
            let navi = self.storyboard!.instantiateViewController(identifier: kEditProfileNavID) as! UINavigationController
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
        } else {
            if let _ = LCApplication.default.currentUser {
                self.showTextHUD("关注和取消关注功能")
            } else {
                self.showLoginHUD()
            }
        }
    }
    
}
