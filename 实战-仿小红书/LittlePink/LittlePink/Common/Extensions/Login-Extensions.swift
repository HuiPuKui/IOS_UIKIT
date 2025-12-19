//
//  LoginVC-LocalLogin.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/15.
//

import Foundation

extension UIViewController {
    
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

// MARK: - 监听

extension UIViewController {
    
    @objc private func otherLogin() {
        
    }
    
    @objc private func dismissLocalLoginVC() {
        JVERIFICATIONService.dismissLoginController(animated: true, completion: {
            
        })
    }
    
}

// MARK: - UI

extension UIViewController {
    
    private func setLocalLoginUI() {
        let config = JVUIConfig()
        
        // 状态栏
        config.prefersStatusBarHidden = true
        
        // 导航栏
        config.navTransparent = true
        config.navText = NSAttributedString(string: " ")
        config.navReturnHidden = true
        config.navControl = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(self.dismissLocalLoginVC))
        
        // 统一的水平居中的约束
        let constraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)!
        
        // logo
        let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/7, constant: 0)!
        config.logoConstraints = [constraintX, logoConstraintY]
        
        // 手机号码
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.numberConstraints = [constraintX, numberConstraintY]
        
        // slogan-xx运营商提供认证服务的标语
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)!
        config.sloganConstraints = [constraintX, sloganConstraintY]
        
        // 一键登录按钮
        config.logBtnText = "同意协议并一键登录"
        config.logBtnImgs = [
            UIImage(named: "localLoginBtn-nor")!,
            UIImage(named: "localLoginBtn-nor")!,
            UIImage(named: "localLoginBtn-hig")!
        ]
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)!
        config.logBtnConstraints = [constraintX, logBtnConstraintY]
        
        // 隐私协议勾选框
        config.privacyState = true // 默认勾选
        config.checkViewHidden = true // 隐藏
        
        // 用户协议和隐私政策
        config.appPrivacyOne = ["用户协议", "https://www.cctalk.com/m/group/86306378"]
        config.appPrivacyTwo = ["隐私政策", "https://www.cctalk.com/m/group/86308246"]
        config.privacyComponents = ["登录注册代表你已同意", "以及", "和", " "]
        config.appPrivacyColor = [UIColor.secondaryLabel, blueColor]
        config.privacyTextAlignment = .center
        
        let privacyConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)!
        let privacyConstraintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)!
        config.privacyConstraints = [constraintX, privacyConstraintY, privacyConstraintW]
        
        // 隐私协议页面
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")!
        
        // 运行自定义的UI并自定义一个button加到customView上
        JVERIFICATIONService.customUI(with: config) { customView in
            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("其它方式登录", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpInside)
            customView.addSubview(otherLoginBtn)
            
            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 170),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
        }
    }
    
}
