//
//  LoginVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/15.
//

import UIKit

class LoginVC: UIViewController {

    lazy private var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.loginBtn)
        self.setUI()
    }
    
    private func setUI() {
        self.loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loginBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.loginBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    @objc private func login() {
#if targetEnvironment(simulator)
        self.presentCodeLoginVC()
#else
        self.localLogin()
#endif
    }

}
