//
//  MeVC-BackOrDrawer.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/14.
//

import Foundation

extension MeVC {
    
    @objc func backOrDrawer(_ sender: UIButton) {
        if self.isFromNote {
            self.dismiss(animated: true)
        } else {
            // 抽屉效果
        }
    }
    
}
