//
//  MeVC-HeaderView.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/15.
//

import Foundation
import LeanCloud

extension MeVC {
    
    func setHeaderView() -> UIView {
        self.meHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.meHeaderView.heightAnchor.constraint(equalToConstant: self.meHeaderView.rootStackView.frame.height + 26).isActive = true
        
        self.meHeaderView.user = self.user
        if self.isFromNote {
            self.meHeaderView.backOrDrawerBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        self.meHeaderView.backOrDrawerBtn.addTarget(self, action: #selector(backOrDrawer), for: .touchUpInside)
        
        if self.isMySelf {
            self.meHeaderView.introLabel.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(editIntro)
                )
            )
        } else {
            if self.user.getExactStringVal(kIntroCol).isEmpty {
                self.meHeaderView.introLabel.isHidden = true
            }
            
            if let _ = LCApplication.default.currentUser {
                // 若已登录需要判断是否已经关注此人 -- 略
                self.meHeaderView.editOrFollowBtn.setTitle("关注", for: .normal)
                self.meHeaderView.editOrFollowBtn.backgroundColor = mainColor
            } else {
                self.meHeaderView.editOrFollowBtn.setTitle("关注", for: .normal)
                self.meHeaderView.editOrFollowBtn.backgroundColor = mainColor
            }
            
            self.meHeaderView.settingOrChatBtn.setImage(
                fontIcon("ellipsis.bubble", fontSize: 13),
                for: .normal
            )
        }
        
        self.meHeaderView.editOrFollowBtn.addTarget(
            self,
            action: #selector(editOrFollow),
            for: .touchUpInside
        )
        
        self.meHeaderView.settingOrChatBtn.addTarget(
            self,
            action: #selector(settingOrChat),
            for: .touchUpInside
        )
        
        return self.meHeaderView
    }
    
}
