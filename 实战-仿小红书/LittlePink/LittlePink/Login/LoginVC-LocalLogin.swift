//
//  LoginVC-LocalLogin.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/15.
//

import Foundation

extension LoginVC {
    
    @objc func localLogin() {
        
        self.showLoadHUD()
        
        let config = JVAuthConfig()
        config.appKey = kJAppKey
        config.authBlock = { _ in
            if JVERIFICATIONService.isSetupClient() {
                // 预取号（可验证当前运营商网络是否可以进行一键登录操作）-- 取的手机号为 136****3451
                JVERIFICATIONService.preLogin(5000) { (result) in
                    self.hideLoadHUD()
                    
                    if let code = result["code"] as? Int, code == 7000 {
                        // 预取号成功
                        self.setLocalLoginUI()
                        self.presentLocalLoginVC()
                    } else {
                        print("预取号失败，错误码: \(String(describing: result["code"]))，错误描述: \(String(describing: result["content"]))")
                    }
                }
            } else {
                self.hideLoadHUD()
                print("初始化一键登录失败")
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
    
    private func setLocalLoginUI() {
        let config = JVUIConfig()
        config.prefersStatusBarHidden = true
        config.navTransparent = true
        config.navText = NSAttributedString(string: "")
        
//        let logoConstraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1/7, constant: 0)
        
        JVERIFICATIONService.customUI(with: config)
    }
    
    // MARK: - 弹出一键登录授权页 + 用户点击登录后
    private func presentLocalLoginVC() {
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5 * 1000, completion: { (result) in
            if let token = result["loginToken"] {
                // 一键登录成功
                JVERIFICATIONService.clearPreLoginCache()
            } else {
                print("一键登录失败")
            }
        }) { (type, content) in
            print("一键登录 actionBlock: type - \(type), content = \(content)")
        }
    }
    
}
