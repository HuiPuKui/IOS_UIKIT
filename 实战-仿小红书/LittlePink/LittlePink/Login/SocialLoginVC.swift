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

        do {
            let testObject = LCObject(className: "TestObject")
            try testObject.set("words", value: "Hello world!")
            let result = testObject.save()
            if let error = result.error {
                print(error)
            }
        } catch {
            print(error)
        }
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
