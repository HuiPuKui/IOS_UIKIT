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
        let headerView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: headerView.rootStackView.frame.height + 16).isActive = true
        
        headerView.user = self.user
        if self.isFromNote {
            headerView.backOrDrawerBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        headerView.backOrDrawerBtn.addTarget(self, action: #selector(backOrDrawer), for: .touchUpInside)
        
        if self.isMySelf {
            
        } else {
            if self.user.getExactStringVal(kIntroCol).isEmpty {
                headerView.introLabel.isHidden = true
            }
            
            if let _ = LCApplication.default.currentUser {
                // 若已登录需要判断是否已经关注此人 -- 略
                headerView.editOrFollowBtn.setTitle("关注", for: .normal)
                headerView.editOrFollowBtn.backgroundColor = mainColor
            } else {
                headerView.editOrFollowBtn.setTitle("关注", for: .normal)
                headerView.editOrFollowBtn.backgroundColor = mainColor
            }
            
            headerView.settingOrChatBtn.setImage(
                fontIcon("ellipsis.bubble", fontSize: 13),
                for: .normal
            )
        }
        
        return headerView
    }
    
}
