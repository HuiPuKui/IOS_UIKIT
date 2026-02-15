//
//  MeVC-UI.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/2/11.
//

import Foundation
import SegementSlide

extension MeVC {
    
    func setUI() {
        self.scrollView.backgroundColor = .systemBackground
        self.contentView.backgroundColor = .systemBackground
        self.switcherView.backgroundColor = .systemBackground
        
        let statusBarOverlayView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: screenRect.width,
                height: kStatusBarH
            )
        )
        statusBarOverlayView.backgroundColor = .systemBackground
        self.view.addSubview(statusBarOverlayView)
        
        self.defaultSelectedIndex = 0
        self.reloadData()
    }
    
}
