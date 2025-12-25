//
//  SocialLoginVC.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/21.
//

import UIKit
import AuthenticationServices
import LeanCloud

class SocialLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInWithAlipay(_ sender: Any) {
        self.signInWithAlipay()
    }
    
    @IBAction func signInWithApple(_ sender: Any) {
        // 需要开发者账号，并在 Caoability 添加 Sign in with Apple
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}
