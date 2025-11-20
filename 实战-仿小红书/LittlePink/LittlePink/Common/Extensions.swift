//
//  Extensions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/11.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var radius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

extension UIViewController {
    
    // MARK: - 展示加载框或提示框
    
    // MARK: - 加载框 -- 手动隐藏
    
    // MARK: - 提示框 -- 自动隐藏
    
    func showTextHUD(_ title: String, _ subTitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text // 不指定的话显示菊花和下面配置的文本
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
}

extension Bundle {
    
    var appName: String {
        if let appName = self.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        } else {
            return self.infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
    
}
