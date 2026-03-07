//
//  Global-Functions.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2026/3/7.
//

import Foundation

// MARK: - 全局函数
func largeIcon(_ iconName: String, with color: UIColor = .label) -> UIImage {
    let config = UIImage.SymbolConfiguration(scale: .large)
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    return icon.withTintColor(color)
}

func fontIcon(_ iconName: String, fontSize: CGFloat, with color: UIColor = .label) -> UIImage {
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: fontSize))
    let icon = UIImage(systemName: iconName, withConfiguration: config)!
    return icon.withTintColor(color)
}

func showGlobalTextHUD(_ title: String) {
    let window = UIApplication.shared.windows.last!
    let hud = MBProgressHUD.showAdded(to: window, animated: true)
    hud.mode = .text
    hud.label.text = title
    hud.hide(animated: true, afterDelay: 2)
}

func jumpToSetting() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
}
